# Vocly Implementation Status

This document explains what has been done so far and what remains, split by mobile, server, and landing page.

## 1. Mobile App

Path: `mobileapp/`

### MVP Scope

The visible app is intentionally limited to three tabs:

- Home: daily Basic → Pro upgrade cards.
- Speak: practise and score today’s upgraded phrase.
- Profile: focus, streak, plan, upgrade, and sign out.

Writing and Progress are not part of the current MVP navigation. They can be
reintroduced after the core speaking loop is validated.

### Done

- Flutter app structure exists.
- Main feature folders exist:
  - Auth.
  - Onboarding.
  - Home shell.
  - Daily Upgrades.
  - Writing.
  - Pronunciation.
  - Progress.
  - Profile.
  - Paywall.
- App routing exists with GoRouter.
- Shared design widgets exist:
  - `AppButton`
  - `AppCard`
  - `AppTextField`
  - `AppSnackbar`
  - `AppScreen`
  - `AppPill`
  - `AppStatCard`
  - and supporting widgets.
- App button was updated to text-only.
- Brand colors are moving toward the maroon/cream palette.
- Supabase Flutter dependency has been added.
- Environment config supports:
  - Supabase URL.
  - Supabase anon key.
  - Backend base URL.
  - Backend auth token.
  - RevenueCat keys.
  - PostHog key/host.
- App startup initializes:
  - Supabase when configured.
  - RevenueCat when configured.
  - Notifications.
  - PostHog when configured.
- Auth repository exists.
- Session model was separated into `AppSession`.
- Session provider supports:
  - Supabase-backed session.
  - Local demo fallback.
- Login and register screens call session provider.
- Google sign-in method exists in repository/provider.
- API client adds Supabase auth headers for Edge Function calls.
- Writing repository can call `/check-writing`.
- Writing flow handles free limit and routes to paywall.
- Daily Upgrade repository calls `/get-upgrade-cards` and
  `/complete-upgrade-card`.
- The home flow now implements all four card pages: upgrade, context, usage,
  and practice.
- Demo upgrade cards keep local mode usable.
- Upgrade free-limit responses route to the paywall.
- Onboarding goals now match the v2 communication domains.
- Onboarding is a focused four-step flow ending with a real Basic → Pro lesson
  preview.
- Splash is a logo-only transition into account creation.
- Home presents the Daily Upgrade as a speaking lesson with context, usage, and
  speaking practice.
- RevenueCat offerings, package selection, purchase, and restore flows are
  implemented.
- Authenticated Supabase users are identified to RevenueCat.
- `revenuecat-webhook` synchronizes the `pro` entitlement to
  `profiles.is_pro`.
- Analyzer passed after the integration work.

### Partially Done

- Auth UI exists but still needs polished loading/error states.
- Onboarding UI can update the profile through the auth repository when
  Supabase is configured.
- The internal feature folder is still named `lessons`; a later mechanical
  rename to `upgrades` remains.
- Writing result UI exists, but history needs full Supabase-backed data loading.
- Pronunciation UI exists, but full audio upload and Speechace result flow needs final verification.
- Progress UI exists, but should be connected fully to Supabase stats.
- Paywall code is complete, but real App Store/Play products and RevenueCat
  dashboard configuration are still required.
- Notification service exists, but final schedule rules need confirmation.

### Not Done Yet

- Real Supabase project values need to be provided in `.env`.
- `SUPABASE_ANON_KEY` must be added to local `.env`.
- Google OAuth native setup is not complete:
  - iOS URL scheme.
  - Android intent filter.
  - Supabase Google provider dashboard settings.
- End-to-end auth must be tested against a real Supabase project.
- End-to-end writing check must be tested against deployed function and Gemini secret.
- End-to-end pronunciation scoring must be tested with audio upload and Speechace secret.
- RevenueCat public SDK keys, store products, the `pro` entitlement, and a
  current offering must be configured.
- Error, empty, and loading states should be reviewed across all screens.

## 2. Server

Path: `server/`

### Done

- Server folder exists separately from Flutter.
- Supabase schema file exists:
  - `server/schema.sql`
- Edge Functions exist:
  - `get-upgrade-cards`
  - `complete-upgrade-card`
  - `update-streak`
  - `check-writing`
  - `score-pronunciation`
  - `revenuecat-webhook`
- Shared function helpers exist:
  - CORS.
  - HTTP responses.
  - Supabase client/auth helpers.
- Server README exists with deployment commands.
- Functions are intended to keep API secrets server-side.

### Partially Done

- Schema now includes the v2 product tables:
  - upgrade cards and card progress.
  - phrase bank.
  - situation scenarios and sessions.
  - quiz questions and attempts.
  - AI feedback, pronunciation history, and daily usage.
- `server/seed.sql` includes ten starter upgrade cards.
- Streak function exists.
- Server functions need deployment to a real Supabase project before the app can work as a real product.

### Not Done Yet

- Apply the new schema and seed to a real Supabase project.
- Supabase Storage bucket `audio_recordings` must be created.
- Storage policies for user-owned audio paths must be added.
- Secrets must be set:
  - `SUPABASE_SERVICE_ROLE_KEY`
  - `GEMINI_API_KEY`
  - `SPEECHACE_API_KEY`
  - `REVENUECAT_WEBHOOK_SECRET`
- Functions must be deployed:
  - `get-upgrade-cards`
  - `complete-upgrade-card`
  - `update-streak`
  - `check-writing`
  - `score-pronunciation`
  - `revenuecat-webhook`
- End-to-end auth/function calls need to be tested with real JWTs.

## 3. Landing Page

Path: `landingpage/`

### Done

- Next.js 14 project was created manually in the existing `landingpage` folder.
- TypeScript is configured.
- Tailwind is configured.
- `tsconfig.json` alias was fixed with `baseUrl`.
- Landing page uses the current brand palette:
  - Primary maroon.
  - Primary light.
  - Gold accent.
  - Cream background.
  - Ink text.
- Content file exists:
  - `landingpage/lib/content.ts`
- Landing sections exist:
  - Navbar.
  - Hero.
  - Social proof.
  - Problem.
  - Features.
  - How it works.
  - Testimonials.
  - Pricing.
  - FAQ.
  - Final CTA.
  - Footer.
- Hero includes a coded phone mockup placeholder.
- Metadata is configured.
- Production build passed with `npm run build`.
- Dev server was started successfully at `http://localhost:3000`.

### Partially Done

- Store and waitlist URLs are placeholders.
- Visual mockup is coded, not a real app screenshot.
- Font stack uses CSS font names/fallbacks because `next/font/google` could not fetch Google Fonts in the local build environment.

### Not Done Yet

- Replace `APP_STORE_URL`, `PLAY_STORE_URL`, and `WAITLIST_URL` in `landingpage/lib/content.ts`.
- Add real `public/mockup.png`.
- Add real `public/og-image.png`.
- Add real `public/favicon.ico`.
- Decide whether CTA should say download or waitlist before app launch.
- Deploy to Vercel.
- Add custom domain and DNS when ready.
- Review npm audit warnings.

## 4. Why The Mobile App Currently Feels Like UI Only

The app intentionally has fallback/demo mode so screens can be viewed before backend setup.

For real functionality, the following must exist:

- Supabase project.
- `SUPABASE_URL`.
- `SUPABASE_ANON_KEY`.
- Supabase schema applied.
- Edge Functions deployed.
- Required server secrets set.
- User authenticated with a real Supabase session.

Without those, auth and feature calls cannot fully work, so repositories either use local demo data or no-op behavior.

## 5. Recommended Next Steps

### Step 1: Build Situation Coach

Implement the situation picker, practice input, AI feedback result, and
`situation-coach` Edge Function.

### Step 2: Set Up Supabase

Create the project, run schema, create storage bucket, set policies, set secrets.

### Step 3: Deploy Functions

Deploy all Edge Functions and test them with a real JWT.

### Step 4: Add Mobile `.env`

Create `mobileapp/.env` with Supabase and service keys that are safe for the client.

Never add server secrets to Flutter.

### Step 5: Test Core Flow

Test in this order:

1. Register.
2. Complete onboarding.
3. Fetch upgrade cards.
4. Complete an upgrade card.
5. Run writing check.
6. Record pronunciation.
7. Check progress.
8. Try paywall.

### Step 6: Polish Production UX

Add loading, error, empty, and success states where needed.

### Step 7: Landing Launch Prep

Add store links, screenshots, OG image, favicon, and deploy to Vercel.
