import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const SPEECHACE_API_KEY = Deno.env.get("SPEECHACE_API_KEY")!;

serve(async (req) => {
  if (req.method !== "POST") return new Response("Method not allowed", { status: 405 });
  if (!req.headers.get("Authorization")) return new Response("Unauthorized", { status: 401 });

  const formData = await req.formData();
  const audioFile = formData.get("audio") as File | null;
  const word = formData.get("word") as string | null;
  if (!audioFile || !word) {
    return new Response(JSON.stringify({ error: "Missing audio or word" }), { status: 400 });
  }

  const speechaceForm = new FormData();
  speechaceForm.append("user_audio_file", audioFile);
  speechaceForm.append("text", word);
  speechaceForm.append("dialect", "en-us");

  const response = await fetch(
    `https://api.speechace.co/api/scoring/text/v9/json?key=${SPEECHACE_API_KEY}&dialect=en-us&user_id=app_user`,
    { method: "POST", body: speechaceForm },
  );

  return new Response(JSON.stringify(await response.json()), { headers: { "Content-Type": "application/json" } });
});
