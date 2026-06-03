import { corsHeaders } from "./cors.ts";

type JsonValue = Record<string, unknown> | unknown[];

export class HttpError extends Error {
  constructor(message: string, readonly status = 400, readonly details?: unknown) {
    super(message);
  }
}

export function json(data: JsonValue, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      ...corsHeaders,
      "Content-Type": "application/json",
    },
  });
}

export function error(message: string, status = 400, details?: unknown): Response {
  return json({ error: message, details }, status);
}

export function errorFromUnknown(cause: unknown, fallbackMessage: string): Response {
  if (cause instanceof HttpError) {
    return error(cause.message, cause.status, cause.details);
  }
  return error(fallbackMessage, 500, cause);
}
