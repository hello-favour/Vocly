import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient, requireUserId } from "../_shared/supabase.ts";

const allowedLevels = new Set(["beginner", "intermediate", "advanced"]);
const allowedDomains = new Set([
  "professional",
  "social",
  "interview",
  "smart_replies",
  "grammar_fix",
]);

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;
  if (req.method !== "GET") return error("Method not allowed", 405);

  const url = new URL(req.url);
  const level = url.searchParams.get("level") ?? "intermediate";
  const domain = url.searchParams.get("domain") ?? "professional";

  if (!allowedLevels.has(level)) return error("Invalid level", 400);
  if (!allowedDomains.has(domain)) return error("Invalid domain", 400);

  try {
    const supabase = createAdminClient();
    const userId = await requireUserId(req, supabase);

    const [{ data: profile, error: profileError }, { data: used, error: usedError }] =
      await Promise.all([
        supabase.from("profiles").select("is_pro").eq("id", userId).single(),
        supabase
          .from("user_card_progress")
          .select("card_id")
          .eq("user_id", userId)
          .gte("completed_at", `${new Date().toISOString().slice(0, 10)}T00:00:00Z`),
      ]);

    if (profileError) throw profileError;
    if (usedError) throw usedError;

    const completedToday = used?.length ?? 0;
    if (!profile?.is_pro && completedToday >= 3) {
      return json({
        upgrade_cards: [],
        daily_limit: 3,
        limit_reached: true,
      });
    }

    const limit = profile?.is_pro ? 20 : 3 - completedToday;
    let query = supabase
      .from("upgrade_cards")
      .select("*")
      .eq("level", level)
      .eq("domain", domain)
      .lte("published_at", new Date().toISOString().slice(0, 10))
      .order("published_at", { ascending: false })
      .limit(limit);

    const usedIds = (used ?? []).map((row) => row.card_id);
    if (usedIds.length > 0) {
      query = query.not("id", "in", `(${usedIds.join(",")})`);
    }

    const { data, error: dbError } = await query;
    if (dbError) throw dbError;

    let cards = data ?? [];
    if (cards.length === 0) {
      let fallbackQuery = supabase
        .from("upgrade_cards")
        .select("*")
        .eq("domain", domain)
        .lte("published_at", new Date().toISOString().slice(0, 10))
        .order("published_at", { ascending: false })
        .limit(limit);
      if (usedIds.length > 0) {
        fallbackQuery = fallbackQuery.not("id", "in", `(${usedIds.join(",")})`);
      }
      const fallback = await fallbackQuery;
      if (fallback.error) throw fallback.error;
      cards = fallback.data ?? [];
    }

    return json({ upgrade_cards: cards, daily_limit: limit });
  } catch (cause) {
    return errorFromUnknown(cause, "Failed to load upgrade cards");
  }
});
