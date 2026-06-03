# FluentAI

Daily English communication coach for non-native speakers. The mobile app talks to the TypeScript backend functions in `../server/functions`; Supabase database work stays server-side.

## Run

```bash
flutter pub get
flutter run --dart-define-from-file=.env
```

For local demo mode, the app also runs without `.env`; repositories fall back to sample lessons and mock AI/pronunciation results.

## Environment

Create `.env` locally:

```bash
BACKEND_BASE_URL=http://localhost:54321/functions/v1
BACKEND_AUTH_TOKEN=optional-supabase-user-jwt-for-protected-functions
SUPABASE_URL=https://xxxx.supabase.co
REVENUECAT_APPLE_KEY=appl_...
REVENUECAT_GOOGLE_KEY=goog_...
POSTHOG_API_KEY=phc_...
POSTHOG_HOST=https://app.posthog.com
```

## Backend

Run `../server/schema.sql` in Supabase SQL Editor, then deploy the TypeScript functions from `../server/functions`.

```bash
supabase functions deploy get-lessons --project-ref YOUR_PROJECT_REF
supabase functions deploy complete-lesson --project-ref YOUR_PROJECT_REF
supabase functions deploy update-streak --project-ref YOUR_PROJECT_REF
supabase functions deploy check-writing --project-ref YOUR_PROJECT_REF
supabase functions deploy score-pronunciation --project-ref YOUR_PROJECT_REF
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=...
supabase secrets set GEMINI_API_KEY=...
supabase secrets set SPEECHACE_API_KEY=...
```
