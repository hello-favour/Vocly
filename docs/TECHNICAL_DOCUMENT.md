# Vocly Technical Document

## 1. System Overview

Vocly has three main parts:

- `mobileapp/`: Flutter mobile app.
- `server/`: Supabase schema and TypeScript Edge Functions.
- `landingpage/`: Next.js landing page.

The intended architecture is:

```text
Flutter UI
  -> Riverpod Provider
    -> Repository
      -> Supabase / Edge Function / RevenueCat
```

Widgets should not call Supabase directly. Data access belongs in repositories.

## 2. Mobile App

### Stack

- Flutter.
- Riverpod.
- GoRouter.
- Dio.
- Supabase Flutter.
- RevenueCat.
- PostHog.
- SharedPreferences fallback for local demo mode.

### Entry Point

File: `mobileapp/lib/main.dart`

Startup initializes:

- Flutter bindings.
- Supabase, only when `SUPABASE_URL` and `SUPABASE_ANON_KEY` exist.
- RevenueCat, only when platform key exists.
- Notification service.
- PostHog, only when key exists.

### Environment

File: `mobileapp/lib/config/env.dart`

Runtime values are read with `String.fromEnvironment`.

Expected `.env` values:

```env
SUPABASE_URL=
SUPABASE_ANON_KEY=
BACKEND_BASE_URL=
BACKEND_AUTH_TOKEN=
REVENUECAT_APPLE_KEY=
REVENUECAT_GOOGLE_KEY=
POSTHOG_API_KEY=
POSTHOG_HOST=
```

Run with:

```bash
cd mobileapp
flutter run --dart-define-from-file=.env
```

### Demo Mode

If Supabase and backend env values are missing, parts of the app fall back to local/demo behavior.

This is why the app can look like only UI: without real keys and deployed functions, repositories return demo lessons or mock results.

### Navigation

File: `mobileapp/lib/config/router.dart`

Routing uses GoRouter and `appSessionProvider`.

Current behavior:

- Unsigned users go to auth.
- Signed users without onboarding go to onboarding.
- Signed and onboarded users go to the lessons tab.

### Auth and Session

Files:

- `mobileapp/lib/features/auth/data/auth_repository.dart`
- `mobileapp/lib/features/session/app_session.dart`
- `mobileapp/lib/features/session/app_session_provider.dart`

Auth repository handles:

- Current Supabase session lookup.
- Email/password sign in.
- Email/password sign up.
- Google OAuth.
- Profile fetch from `profiles`.
- Onboarding profile update.
- Sign out.

Session provider handles:

- Remote session when Supabase is configured.
- Local fallback session when Supabase is not configured.

### API Client

File: `mobileapp/lib/core/network/api_client.dart`

Responsibilities:

- Build function base URL.
- Attach Supabase `apikey`.
- Attach current user bearer token when logged in.
- Fall back to `BACKEND_AUTH_TOKEN` when provided.

### Writing Flow

Files:

- `mobileapp/lib/features/writing/data/writing_repository.dart`
- `mobileapp/lib/features/writing/providers/writing_provider.dart`
- `mobileapp/lib/features/writing/screens/writing_screen.dart`

Flow:

```text
WritingScreen
  -> writingCheckProvider
    -> WritingRepository.checkWriting
      -> /check-writing Edge Function
```

If backend is not configured, demo feedback is returned.

If the server returns `FREE_LIMIT_REACHED`, Flutter throws `FreeLimitReachedException` and routes to the paywall.

### Lessons Flow

Files:

- `mobileapp/lib/features/lessons/data/lessons_repository.dart`
- `mobileapp/lib/features/lessons/providers/lessons_provider.dart`
- `mobileapp/lib/features/lessons/screens/lessons_screen.dart`
- `mobileapp/lib/features/lessons/screens/lesson_detail_screen.dart`

Expected remote endpoints:

- `GET /get-lessons?level=...`
- `POST /complete-lesson`

If backend is not configured, demo lessons are used.

### Pronunciation Flow

Files:

- `mobileapp/lib/features/pronunciation/data/pronunciation_repository.dart`
- `mobileapp/lib/features/pronunciation/providers/pronunciation_provider.dart`
- `mobileapp/lib/features/pronunciation/screens/pronunciation_screen.dart`

Expected final behavior:

- Record audio.
- Upload to Supabase Storage.
- Call `/score-pronunciation`.
- Show result screen.
- Save history server-side.

### Theme

Primary brand palette:

```dart
primary = Color(0xFF6D1028)
primaryLight = Color(0xFF9F2445)
accent = Color(0xFFC99045)
background = Color(0xFFFFFCFA)
backgroundDeep = Color(0xFFF8EEF1)
ink = Color(0xFF241218)
```

## 3. Server

### Stack

- Supabase Postgres.
- Supabase Auth.
- Supabase Storage.
- Supabase Edge Functions.
- TypeScript/Deno.

### Files

- `server/schema.sql`
- `server/functions/get-lessons/index.ts`
- `server/functions/complete-lesson/index.ts`
- `server/functions/update-streak/index.ts`
- `server/functions/check-writing/index.ts`
- `server/functions/score-pronunciation/index.ts`
- `server/functions/_shared/*`

### Database

Schema includes:

- `profiles`
- `lessons`
- `user_lesson_progress`
- `ai_feedback_history`
- `pronunciation_history`
- `daily_usage_log`
- `update_streak` RPC

Important note: the app expects `profiles.onboarding_done`. If it is missing in `server/schema.sql`, the schema must be updated before production use.

### Edge Functions

#### `get-lessons`

Returns published lessons by user level.

#### `complete-lesson`

Records lesson progress, awards coins, and updates streak.

#### `update-streak`

Updates current user's streak.

#### `check-writing`

Calls Gemini, stores AI feedback history, and updates streak.

#### `score-pronunciation`

Calls Speechace, stores pronunciation history, and updates streak.

### Required Server Secrets

```bash
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=...
supabase secrets set GEMINI_API_KEY=...
supabase secrets set SPEECHACE_API_KEY=...
```

### Deploy Commands

```bash
supabase functions deploy get-lessons
supabase functions deploy complete-lesson
supabase functions deploy update-streak
supabase functions deploy check-writing
supabase functions deploy score-pronunciation
```

## 4. Landing Page

### Stack

- Next.js 14.
- App Router.
- TypeScript.
- Tailwind CSS.
- Framer Motion.
- Lucide React.

### Files

- `landingpage/app/layout.tsx`
- `landingpage/app/page.tsx`
- `landingpage/app/globals.css`
- `landingpage/lib/content.ts`
- `landingpage/components/*`
- `landingpage/tailwind.config.ts`

### Content Source

All editable marketing copy lives in:

```text
landingpage/lib/content.ts
```

### Theme

The landing page now uses the same maroon/cream brand direction as the mobile app.

### Run

```bash
cd landingpage
npm install
npm run dev
```

### Build

```bash
npm run build
```

## 5. External Services

### Supabase

Used for:

- Auth.
- Profiles.
- Lessons.
- Progress.
- Feedback history.
- Pronunciation history.
- Daily usage/streaks.
- Storage for audio recordings.
- Edge Functions.

### Gemini

Used by `check-writing`.

The API key must stay server-side.

### Speechace

Used by `score-pronunciation`.

The API key must stay server-side.

### RevenueCat

Used for subscriptions and pro entitlement.

RevenueCat should be treated as the source of truth for pro status.

### PostHog

Used for analytics.

## 6. Security Rules

- Do not put Gemini or Speechace keys in Flutter.
- Do not put service role key in Flutter.
- Edge Functions must validate Supabase user JWTs for protected operations.
- Users should only read and write their own profile/progress/history data.
- Audio uploads should be stored under a user-owned path.

## 7. Known Technical Gaps

- Supabase schema needs to be reconciled with the latest PRD and app fields.
- Auth screens need proper loading/error UI.
- Google OAuth native platform configuration still needs final setup.
- Pronunciation upload/scoring needs full end-to-end mobile wiring.
- RevenueCat paywall purchase actions need full product/offering implementation.
- Landing page needs real store URLs, `mockup.png`, `og-image.png`, and `favicon.ico`.
