import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient, requireUserId, updateStreak } from "../_shared/supabase.ts";

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;

  if (req.method !== "POST") return error("Method not allowed", 405);

  try {
    const supabase = createAdminClient();
    const userId = await requireUserId(req, supabase);
    await updateStreak(supabase, userId);
    return json({ ok: true });
  } catch (cause) {
    return errorFromUnknown(cause, "Failed to update streak");
  }
});
