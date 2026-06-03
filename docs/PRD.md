# Vocly Product Requirements Document

## 1. Product Summary

Vocly is a daily English communication coach for non-native English speakers who want to sound clearer, more confident, and more professional in real-world situations.

The product combines short daily lessons, AI writing feedback, pronunciation scoring, streaks, progress tracking, and a subscription upgrade path.

## 2. Product Goal

Help users improve their practical English communication in 10 minutes a day.

The main user outcome is confidence: users should feel more prepared to write emails, speak in meetings, pronounce words correctly, and communicate without overthinking every sentence.

## 3. Target Audience

- Non-native English speakers.
- Age range: roughly 20-35.
- Africa-first market focus.
- Professionals, students, founders, remote workers, and job seekers.
- Users who already know some English but struggle with clarity, confidence, tone, or pronunciation.

## 4. Core User Problems

- Users freeze in meetings even when they know what they want to say.
- Users reread emails repeatedly because they are unsure if the tone sounds professional.
- Users feel less capable than they are because language blocks their confidence.
- Generic grammar apps do not teach real communication habits.
- Pronunciation practice is hard because users do not know whether they said words correctly.

## 5. Product Positioning

Vocly is not a generic language game and not only a grammar checker.

Vocly is a daily coach for practical communication:

- Learn a useful word, phrase, and grammar tip.
- Check real writing with AI.
- Practice pronunciation and get a score.
- Track progress and build a streak.

## 6. Product Surfaces

### Mobile App

The mobile app is the main product experience. It includes onboarding, lessons, writing feedback, pronunciation practice, progress, profile, coins, and paywall.

### Server

The server layer is Supabase plus TypeScript Edge Functions. It owns database-backed operations, AI calls, pronunciation scoring, streak updates, and secure API secrets.

### Landing Page

The landing page explains the value proposition and converts visitors into downloads or waitlist signups.

## 7. Main Features

### 7.1 Authentication

Users should be able to create an account and sign in.

Supported auth:

- Email and password.
- Google OAuth.

### 7.2 Onboarding

Users provide:

- Name.
- Skill level: beginner, intermediate, advanced.
- Goal: professional, academic, social, travel.
- Daily practice time.

Onboarding stores profile preferences and marks onboarding as complete.

### 7.3 Daily Lessons

Users get lessons matched to their skill level.

Each lesson includes:

- Word of the day.
- Definition.
- Example.
- Useful phrase.
- Phrase meaning.
- Grammar rule.
- Grammar example.

Completing a lesson should:

- Record lesson progress.
- Award coins.
- Update streak.

### 7.4 AI Writing Check

Users paste a sentence or short passage and receive:

- Corrected version.
- Tone.
- Up to three key issues.
- Overall score.
- Confidence tip.
- Summary.

Free users have a daily usage limit. When the limit is reached, the user should be sent to the paywall.

### 7.5 Pronunciation Practice

Users practice a word or sentence by recording audio.

The system should:

- Upload audio securely.
- Send audio to Speechace.
- Return a pronunciation score.
- Save pronunciation history.
- Update streak.

### 7.6 Progress

Users should see:

- Streak count.
- Weekly activity.
- Writing and pronunciation progress.
- Coins.
- Completed lessons.

### 7.7 Profile and Settings

Users should be able to:

- View their profile.
- See coins and streak status.
- Access settings.
- Sign out.
- Restore purchases.

### 7.8 Paywall and Subscription

RevenueCat is the subscription source of truth.

Plans:

- Free.
- Pro yearly.
- Lifetime.

Pro users should get unlimited or expanded access depending on the final entitlement rules.

### 7.9 Landing Page

The landing page should include:

- Sticky nav.
- Hero section with app mockup.
- Social proof.
- Problem section.
- Feature section.
- How it works.
- Testimonials.
- Pricing.
- FAQ.
- Final CTA.
- Footer.

## 8. Success Metrics

Product metrics:

- Account creation rate.
- Onboarding completion rate.
- First lesson completion rate.
- Writing check usage.
- Pronunciation attempt usage.
- Day 1 and Day 7 retention.
- Streak continuation.
- Free-to-Pro conversion.

Landing metrics:

- CTA click-through rate.
- Waitlist or download conversion.
- Pricing section engagement.

## 9. Non-Goals For Current Phase

- Full social community.
- Live tutoring.
- Complex grammar curriculum builder.
- Admin lesson management UI.
- In-app chat bot beyond structured writing feedback.

## 10. Open Product Decisions

- Final App Store and Play Store URLs.
- Whether landing CTA should point to waitlist before app launch.
- Exact free usage limits per feature after launch testing.
- Whether lessons are one per day or multiple per day for free users.
- Final RevenueCat entitlement naming and product IDs.
