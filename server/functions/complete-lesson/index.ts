import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient, requireUserId, updateStreak } from "../_shared/supabase.ts";

type CompleteLessonBody = {
  lesson_id?: string;
};

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;

  if (req.method !== "POST") return error("Method not allowed", 405);

  try {
    const body = await req.json() as CompleteLessonBody;
    if (!body.lesson_id) return error("Missing lesson_id", 400);

    const supabase = createAdminClient();
    const userId = await requireUserId(req, supabase);

    const { error: progressError } = await supabase
      .from("user_lesson_progress")
      .upsert({ user_id: userId, lesson_id: body.lesson_id }, { onConflict: "user_id,lesson_id" });

    if (progressError) throw progressError;

    const { data: profile, error: profileReadError } = await supabase
      .from("profiles")
      .select("coins")
      .eq("id", userId)
      .single();

    if (profileReadError) throw profileReadError;

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
    return errorFromUnknown(cause, "Failed to complete lesson");
  }
});
