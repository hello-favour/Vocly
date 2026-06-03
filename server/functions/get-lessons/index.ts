import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient } from "../_shared/supabase.ts";

const allowedLevels = new Set(["beginner", "intermediate", "advanced"]);

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;

  if (req.method !== "GET") return error("Method not allowed", 405);

  const url = new URL(req.url);
  const level = url.searchParams.get("level") ?? "intermediate";

  if (!allowedLevels.has(level)) {
    return error("Invalid level", 400);
  }

  try {
    const supabase = createAdminClient();
    const { data, error: dbError } = await supabase
      .from("lessons")
      .select("*")
      .eq("level", level)
      .lte("published_at", new Date().toISOString().slice(0, 10))
      .order("published_at", { ascending: false })
      .limit(3);

    if (dbError) throw dbError;
    return json({ lessons: data ?? [] });
  } catch (cause) {
    return errorFromUnknown(cause, "Failed to load lessons");
  }
});
