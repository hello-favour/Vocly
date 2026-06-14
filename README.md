# Vocly

Vocly is a daily English communication coach for non-native speakers. The project is split into three surfaces:

- `mobileapp/` - Flutter mobile app.
- `server/` - Supabase schema and TypeScript Edge Functions.
- `landingpage/` - Next.js landing page.

## Documentation

- Product requirements: `docs/PRD.md` (Vocly v2.0 is canonical)
- Technical architecture: `docs/TECHNICAL_DOCUMENT.md`
- Implementation status: `docs/IMPLEMENTATION_STATUS.md`

## Mobile

```bash
cd mobileapp
flutter pub get
flutter run --dart-define-from-file=.env
```

The mobile app requires Supabase and the deployed Edge Functions. See
[`docs/SUPABASE_SETUP.md`](docs/SUPABASE_SETUP.md) for the exact production
setup.

## Server

```bash
supabase functions deploy get-upgrade-cards
supabase functions deploy complete-upgrade-card
supabase functions deploy update-streak
supabase functions deploy check-writing
supabase functions deploy score-pronunciation
```

Run `server/schema.sql` in Supabase before deploying functions.

## Landing Page

```bash
cd landingpage
npm install
npm run dev
```
