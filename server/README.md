# Vocly Server

TypeScript Supabase Edge Functions live in `server/functions`.

## Structure

- `_shared/` contains reusable CORS, HTTP response, auth, and Supabase admin-client helpers.
- `get-upgrade-cards` reads personalized Basic → Pro cards and enforces the
  free daily allowance.
- `complete-upgrade-card` records card progress, awards coins once, and updates
  streaks.
- `update-streak` updates the current user streak.
- `check-writing` calls Gemini, saves feedback history, and updates streaks.
- `score-pronunciation` calls Speechace, saves pronunciation history, and updates streaks.
- `revenuecat-webhook` keeps `profiles.is_pro` synchronized with the RevenueCat
  `pro` entitlement.

## Required Secrets

```bash
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=...
supabase secrets set GEMINI_API_KEY=...
supabase secrets set SPEECHACE_API_KEY=...
supabase secrets set REVENUECAT_WEBHOOK_SECRET=...
```

`SUPABASE_URL` is provided automatically by Supabase Edge Functions.

## Deploy

```bash
supabase functions deploy get-upgrade-cards
supabase functions deploy complete-upgrade-card
supabase functions deploy update-streak
supabase functions deploy check-writing
supabase functions deploy score-pronunciation
supabase functions deploy revenuecat-webhook
```

Protected functions expect a Supabase user JWT:

```http
Authorization: Bearer <user-access-token>
```

Run `schema.sql`, then `seed.sql`, before testing the upgrade flow.
