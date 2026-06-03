# Vocly

Vocly is a daily English communication coach for non-native speakers. The project is split into three surfaces:

- `mobileapp/` - Flutter mobile app.
- `server/` - Supabase schema and TypeScript Edge Functions.
- `landingpage/` - Next.js landing page.

## Documentation

- Product requirements: `docs/PRD.md`
- Technical architecture: `docs/TECHNICAL_DOCUMENT.md`
- Implementation status: `docs/IMPLEMENTATION_STATUS.md`

## Mobile

```bash
cd mobileapp
flutter pub get
flutter run --dart-define-from-file=.env
```

The app can run in local demo mode without `.env`, but real auth and feature calls require Supabase and deployed Edge Functions.

## Server

```bash
supabase functions deploy get-lessons
supabase functions deploy complete-lesson
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
