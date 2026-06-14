# Vocly

Daily Basic → Pro speaking lessons for people who already speak English and
want to sound more natural, confident, and professional.

## Run

```bash
flutter pub get
flutter run --dart-define-from-file=.env
```

The app requires a configured Supabase project. Copy `.env.example` to `.env`
and replace the two required Supabase values before running it.

## Environment

Create `.env` locally:

```bash
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_PUBLISHABLE_KEY=sb_publishable_...
REVENUECAT_APPLE_KEY=appl_...
REVENUECAT_GOOGLE_KEY=goog_...
POSTHOG_API_KEY=phc_...
POSTHOG_HOST=https://us.i.posthog.com
```

## Backend

Follow [the complete Supabase setup guide](../docs/SUPABASE_SETUP.md). Run
`../server/schema.sql` in Supabase SQL Editor, then `../server/seed.sql`, and
deploy the TypeScript functions from `../server/functions`.

```bash
supabase functions deploy get-upgrade-cards --project-ref YOUR_PROJECT_REF
supabase functions deploy complete-upgrade-card --project-ref YOUR_PROJECT_REF
supabase functions deploy update-streak --project-ref YOUR_PROJECT_REF
supabase functions deploy score-pronunciation --project-ref YOUR_PROJECT_REF
supabase functions deploy revenuecat-webhook --project-ref YOUR_PROJECT_REF
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=...
supabase secrets set SPEECHACE_API_KEY=...
supabase secrets set REVENUECAT_WEBHOOK_SECRET=...
```

## RevenueCat Setup

1. Create the `pro` entitlement.
2. Create a current offering with monthly, annual, and/or lifetime packages.
3. Connect the matching App Store Connect and Google Play products.
4. Add each platform's public RevenueCat SDK key to `.env`.
5. Deploy `revenuecat-webhook` and set its URL in RevenueCat.
6. Set the webhook authorization header to
   `Bearer <REVENUECAT_WEBHOOK_SECRET>`.

The app uses the prices returned by Apple or Google and never hard-codes the
charge shown to a customer.
