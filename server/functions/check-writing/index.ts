import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY")!;
const GEMINI_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`;

const SYSTEM_PROMPT = `You are a professional English communication coach helping non-native speakers improve.
Return only valid JSON with corrected, tone, issues, overall_score, confidence_tip, and summary.
Maximum 3 issues. Keep explanations simple.`;

serve(async (req) => {
  if (req.method !== "POST") return new Response("Method not allowed", { status: 405 });
  if (!req.headers.get("Authorization")) return new Response("Unauthorized", { status: 401 });

  const body = await req.json().catch(() => null) as { text?: string } | null;
  const text = body?.text?.trim();
  if (!text || text.length < 5) {
    return new Response(JSON.stringify({ error: "Text too short" }), { status: 400 });
  }

  const geminiResponse = await fetch(GEMINI_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents: [{ parts: [{ text: SYSTEM_PROMPT }, { text: `Analyse this sentence: "${text}"` }] }],
      generationConfig: { temperature: 0.2, maxOutputTokens: 1024 },
    }),
  });

  if (!geminiResponse.ok) {
    return new Response(JSON.stringify({ error: "Gemini error", detail: await geminiResponse.text() }), { status: 502 });
  }

  const data = await geminiResponse.json();
  const rawText = data?.candidates?.[0]?.content?.parts?.[0]?.text ?? "";
  try {
    return new Response(JSON.stringify(JSON.parse(rawText)), { headers: { "Content-Type": "application/json" } });
  } catch {
    return new Response(JSON.stringify({ error: "Failed to parse Gemini response", raw: rawText }), { status: 500 });
  }
});
