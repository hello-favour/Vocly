import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import {
  createAdminClient,
  requireUserId,
  updateStreak,
} from "../_shared/supabase.ts";

type CompleteCardBody = {
  card_id?: string;
};

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;
  if (req.method !== "POST") return error("Method not allowed", 405);

  try {
    const body = await req.json() as CompleteCardBody;
    if (!body.card_id) return error("Missing card_id", 400);

    const supabase = createAdminClient();
    const userId = await requireUserId(req, supabase);

    const [
      { data: existing, error: existingError },
      { data: profile, error: profileError },
      { data: completedToday, error: countError },
    ] = await Promise.all([
      supabase
        .from("user_card_progress")
        .select("id")
        .eq("user_id", userId)
        .eq("card_id", body.card_id)
        .maybeSingle(),
      supabase.from("profiles").select("coins,is_pro").eq("id", userId).single(),
      supabase.rpc("count_today_cards", { p_user_id: userId }),
    ]);

    if (existingError) throw existingError;
    if (profileError) throw profileError;
    if (countError) throw countError;
    if (existing) return json({ ok: true, coins_awarded: 0 });
    if (!profile?.is_pro && Number(completedToday ?? 0) >= 3) {
      return error("FREE_LIMIT_REACHED", 429);
    }

    const { error: progressError } = await supabase
      .from("user_card_progress")
      .insert({ user_id: userId, card_id: body.card_id });
    if (progressError) throw progressError;

    const { error: coinError } = await supabase
      .from("profiles")
      .update({
        coins: Number(profile?.coins ?? 0) + 10,
        updated_at: new Date().toISOString(),
      })
      .eq("id", userId);
    if (coinError) throw coinError;

    await updateStreak(supabase, userId);
    return json({ ok: true, coins_awarded: 10 });
  } catch (cause) {
    return errorFromUnknown(cause, "Failed to complete upgrade card");
  }
});
