# FluentAI

Daily English communication coach for non-native speakers. The MVP follows the PRD in `FluentAI_MVP_PRD.md`: onboarding, daily lessons, AI writing checks, pronunciation practice, streaks, progress, profile, paywall, Supabase schema, and Edge Function entry points.

## Run

```bash
flutter pub get
flutter run --dart-define-from-file=.env
```

For local demo mode, the app also runs without `.env`; repositories fall back to sample lessons and mock AI/pronunciation results.

## Environment

Create `.env` locally:

```bash
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_ANON_KEY=eyJ...
REVENUECAT_APPLE_KEY=appl_...
REVENUECAT_GOOGLE_KEY=goog_...
POSTHOG_API_KEY=phc_...
POSTHOG_HOST=https://app.posthog.com
```

## Backend

Run `supabase/schema.sql` in Supabase SQL Editor, then deploy:

```bash
supabase functions deploy check-writing
supabase functions deploy score-pronunciation
supabase secrets set GEMINI_API_KEY=...
supabase secrets set SPEECHACE_API_KEY=...
```
