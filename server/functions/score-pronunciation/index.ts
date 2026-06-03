import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient, requireUserId, updateStreak } from "../_shared/supabase.ts";

const SPEECHACE_API_KEY = Deno.env.get("SPEECHACE_API_KEY")!;

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;

  if (req.method !== "POST") return error("Method not allowed", 405);

  try {
    const supabase = createAdminClient();
    const userId = await requireUserId(req, supabase);

    const formData = await req.formData();
    const audioFile = formData.get("audio") as File | null;
    const word = formData.get("word") as string | null;

    if (!audioFile || !word) return error("Missing audio or word", 400);

    const speechaceForm = new FormData();
    speechaceForm.append("user_audio_file", audioFile);
    speechaceForm.append("text", word);
    speechaceForm.append("dialect", "en-us");

    const speechaceResponse = await fetch(
      `https://api.speechace.co/api/scoring/text/v9/json?key=${SPEECHACE_API_KEY}&dialect=en-us&user_id=${userId}`,
      { method: "POST", body: speechaceForm },
    );

    if (!speechaceResponse.ok) {
      return error("Speechace error", 502, await speechaceResponse.text());
    }

    const result = await speechaceResponse.json();
    const scoreOverall = Number(
      result?.text_score?.speechace_score?.pronunciation ??
        result?.score_overall ??
        result?.overall_score ??
        0,
    );

    const { error: insertError } = await supabase
      .from("pronunciation_history")
      .insert({
        user_id: userId,
        word,
        audio_path: `edge-function/${crypto.randomUUID()}.m4a`,
        score_overall: scoreOverall,
        score_json: result,
      });

    if (insertError) throw insertError;

    await updateStreak(supabase, userId);
    return json(result);
  } catch (cause) {
    return errorFromUnknown(cause, "Failed to score pronunciation");
  }
});
