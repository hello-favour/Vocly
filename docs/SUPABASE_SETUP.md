# Vocly Supabase Setup

This setup connects Vocly authentication, onboarding profiles, Basic to Pro
lessons, streaks, pronunciation scoring, password reset, and subscription
status to a real backend.

## 1. Create the project

1. Open <https://supabase.com/dashboard/projects>.
2. Select **New project**.
3. Choose your organization, enter `Vocly`, create a strong database password,
   select the nearest region, and create the project.
4. Store the database password in a password manager. Do not send it in chat or
   put it in the mobile app.

## 2. Copy the mobile-safe values

In the project dashboard, open **Connect** or **Project Settings > API** and
copy:

- **Project URL**, for example `https://abc123.supabase.co`
- **Publishable key**, beginning with `sb_publishable_`

Create `mobileapp/.env` from `mobileapp/.env.example`:

```env
SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
SUPABASE_PUBLISHABLE_KEY=sb_publishable_REPLACE_ME

REVENUECAT_APPLE_KEY=
REVENUECAT_GOOGLE_KEY=
POSTHOG_API_KEY=
POSTHOG_HOST=https://us.i.posthog.com
```

The project URL and publishable key are the only Supabase values that belong in
the Flutter app. Never place the database password, secret key, or service-role
key in `.env`.

## 3. Create the database

1. Open **SQL Editor** in Supabase.
2. Select **New query**.
3. Paste the complete contents of `server/schema.sql`.
4. Select **Run** and confirm there are no errors.
5. Create another query, paste `server/seed.sql`, and run it.

The schema enables Row Level Security. Users can edit only their normal profile
fields; coins, streaks, and Pro access remain backend-controlled.

## 4. Configure authentication

Open **Authentication > Providers > Email**:

1. Keep email/password enabled.
2. Keep **Confirm email** enabled for production.
3. Save.

Open **Authentication > URL Configuration**:

1. Set **Site URL** to your real website, such as `https://vocly.app`.
2. Add these **Redirect URLs**:

```text
com.vocly.app:///auth/login
com.vocly.app:///auth/reset-password
```

Forgot password is already connected in Flutter. Supabase sends the reset
email, the link returns to Vocly, and the reset screen saves the new password.

Google sign-in is optional for the first release. To enable it, open
**Authentication > Providers > Google**, add the Google OAuth client ID and
secret, then add Supabase's displayed callback URL to the authorized redirect
URIs in Google Cloud.

## 5. Install and link the Supabase CLI

From the repository root:

```bash
npx supabase init
npx supabase login
npx supabase link --project-ref YOUR_PROJECT_REF
```

`YOUR_PROJECT_REF` is the first part of the project URL. For
`https://abc123.supabase.co`, it is `abc123`.

The Edge Functions currently live in `server/functions`. Before deployment,
copy that folder into the CLI function directory:

```bash
mkdir -p supabase
cp -R server/functions supabase/functions
```

## 6. Add backend-only secrets

Run these commands locally. Replace each value but do not send the values in
chat:

```bash
npx supabase secrets set SPEECHACE_API_KEY=YOUR_SPEECHACE_KEY
npx supabase secrets set REVENUECAT_WEBHOOK_SECRET=YOUR_RANDOM_WEBHOOK_SECRET
```

Supabase provides `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` to hosted Edge
Functions automatically. The mobile app must never receive the service-role
key.

Gemini is not required for the current speaking-first MVP. Do not deploy
`check-writing` or add a Gemini key unless Writing returns in a later release.

## 7. Deploy the MVP functions

```bash
npx supabase functions deploy get-upgrade-cards
npx supabase functions deploy complete-upgrade-card
npx supabase functions deploy update-streak
npx supabase functions deploy score-pronunciation
npx supabase functions deploy revenuecat-webhook --no-verify-jwt
```

The RevenueCat webhook verifies its own authorization header. The other
functions require the signed-in user's Supabase token.

## 8. Configure RevenueCat

1. Create the Vocly iOS and Android apps in RevenueCat.
2. Use bundle/package ID `com.vocly.app`.
3. Connect App Store Connect and Google Play.
4. Create the entitlement `pro`.
5. Create an offering with monthly and annual packages.
6. Put the public Apple and Google SDK keys in `mobileapp/.env`.
7. Set the RevenueCat webhook URL to:

```text
https://YOUR_PROJECT_REF.supabase.co/functions/v1/revenuecat-webhook
```

8. Configure its authorization header:

```text
Bearer YOUR_REVENUECAT_WEBHOOK_SECRET
```

Use the same secret value set in Supabase. RevenueCat updates `profiles.is_pro`;
the Flutter client cannot grant itself Pro access.

## 9. Run and test

```bash
cd mobileapp
flutter pub get
flutter run --dart-define-from-file=.env
```

Test this order:

1. Create an account and confirm its email.
2. Sign in and complete onboarding.
3. Open a Basic to Pro lesson and complete it.
4. Record a phrase in Speak and receive a real score.
5. Request a password reset and open the email on the test device.
6. Buy and restore a sandbox subscription.
7. Sign out and sign back in.

## What to provide for integration help

You may provide:

```text
SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
SUPABASE_PUBLISHABLE_KEY=sb_publishable_...
PROJECT_REF=YOUR_PROJECT_REF
```

Prefer putting these values directly in `mobileapp/.env` in this workspace
instead of posting them in chat. Never provide the database password,
service-role key, Supabase secret key, Speechace key, RevenueCat webhook secret,
or store credentials.
