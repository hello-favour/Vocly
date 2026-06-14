import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { handleCors } from "../_shared/cors.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient, requireUserId, updateStreak } from "../_shared/supabase.ts";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY")!;
const GEMINI_URL =
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent";

type CheckWritingBody = {
  text?: string;
};

type FeedbackResult = {
  corrected: string;
  tone: "formal" | "informal" | "neutral";
  issues: Array<{
    type: "grammar" | "clarity" | "word_choice" | "tone";
    original: string;
    suggestion: string;
    explanation: string;
  }>;
  overall_score: number;
  confidence_tip: string;
  summary: string;
};

const SYSTEM_PROMPT = `You are a professional English communication coach helping non-native speakers improve.
Analyse the sentence provided and return ONLY a valid JSON object with this exact structure:
{
  "corrected": "the improved sentence",
  "tone": "formal OR informal OR neutral",
  "issues": [
    {
      "type": "grammar OR clarity OR word_choice OR tone",
      "original": "the problematic fragment from the original",
      "suggestion": "better alternative",
      "explanation": "brief, plain-English reason (1 sentence)"
    }
  ],
  "overall_score": <integer 0-100>,
  "confidence_tip": "one short tip to sound more confident or clear",
  "summary": "one sentence summary of the feedback"
}
Rules:
- Return ONLY the JSON object. No markdown, no code fences, no preamble.
- Maximum 3 issues. Focus on the most impactful ones.
- Keep explanations simple.`;

serve(async (req) => {
  const cors = handleCors(req);
  if (cors) return cors;

  if (req.method !== "POST") return error("Method not allowed", 405);

  try {
    const body = await req.json().catch(() => null) as CheckWritingBody | null;
    const text = body?.text?.trim();
    if (!text || text.length < 5) return error("Text too short", 400);

    const supabase = createAdminClient();
    const userId = await requireUserId(req, supabase);

    const geminiResponse = await fetch(GEMINI_URL, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-goog-api-key": GEMINI_API_KEY,
      },
      body: JSON.stringify({
        contents: [
          {
            parts: [
              { text: SYSTEM_PROMPT },
              { text: `Analyse this sentence: "${text}"` },
            ],
          },
        ],
        generationConfig: { temperature: 0.2, maxOutputTokens: 1024 },
      }),
    });

    if (!geminiResponse.ok) {
      return error("Gemini error", 502, await geminiResponse.text());
    }

    const data = await geminiResponse.json();
    const rawText = data?.candidates?.[0]?.content?.parts?.[0]?.text ?? "";
    const feedback = JSON.parse(rawText) as FeedbackResult;

    const { error: insertError } = await supabase
      .from("ai_feedback_history")
      .insert({
        user_id: userId,
        original_text: text,
        feedback_json: feedback,
      });

    if (insertError) throw insertError;

    await updateStreak(supabase, userId);
    return json(feedback);
  } catch (cause) {
    return errorFromUnknown(cause, "Failed to check writing");
  }
});
