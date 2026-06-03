# FluentAI Server

TypeScript Supabase Edge Functions live in `server/functions`.

## Structure

- `_shared/` contains reusable CORS, HTTP response, auth, and Supabase admin-client helpers.
- `get-lessons` reads published lessons by level.
- `complete-lesson` records lesson progress, awards coins, and updates streaks.
- `update-streak` updates the current user streak.
- `check-writing` calls Gemini, saves feedback history, and updates streaks.
- `score-pronunciation` calls Speechace, saves pronunciation history, and updates streaks.

## Required Secrets

```bash
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=...
supabase secrets set GEMINI_API_KEY=...
supabase secrets set SPEECHACE_API_KEY=...
```

`SUPABASE_URL` is provided automatically by Supabase Edge Functions.

## Deploy

```bash
supabase functions deploy get-lessons
supabase functions deploy complete-lesson
supabase functions deploy update-streak
supabase functions deploy check-writing
supabase functions deploy score-pronunciation
```

Protected functions expect a Supabase user JWT:

```http
Authorization: Bearer <user-access-token>
```
