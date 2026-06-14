# Vocly Product Requirements

**Current product direction:** Vocly PRD v2.0, “Speak Like a Pro”.

This document supersedes the former lesson-centric product definition. Vocly is
not a beginner vocabulary or grammar app. It is a communication upgrade system
for people who already speak English and want to sound more natural, confident,
and professional.

## Product Promise

Vocly transforms basic or textbook English into language a confident,
well-spoken professional would naturally use in real situations.

## Target User

- English-speaking professionals and graduates, initially focused on African
  markets.
- People who use English already but freeze, sound overly basic, or struggle
  with tone.
- Not complete beginners, children, or exam-preparation users.

## Communication Domains

- Professional
- Social
- Interview
- Smart replies
- Grammar fixes in context

Onboarding must use these domains to personalize the user’s first content.

## Core Features

### Daily Upgrade Cards

Each card contains four pages:

1. Basic phrase → professional or natural phrase.
2. Two realistic dialogue examples.
3. When to use it, when not to use it, and its register.
4. Spoken or written practice.

Free users receive three cards per day. Completing a card records progress,
updates the streak, and awards 10 coins.

### Situation Coach

Users select a real situation, answer by typing or speaking, and receive an AI
rewrite, confidence feedback, explanations, and scores. Situations include job
interviews, professional emails, manager responses, meetings, networking,
feedback, salary conversations, social conversations, and workplace messages.

Free users receive two sessions per day.

### AI Writing Upgrade

The writing tool must go beyond grammar correction. It detects context, fixes
grammar, upgrades vocabulary and tone, and returns corrected and fully upgraded
versions with grammar, clarity, confidence, tone, and overall scores.

Free users receive five checks per day.

### Pronunciation And Fluency

Users practise words and full upgraded phrases. Results cover pronunciation,
fluency, and naturalness. Free users receive three attempts per day; phrase mode
is a Pro feature.

### Basic Or Pro Quiz

A daily five-question quiz tests natural phrasing, professional choices, and
grammar in context. Free users receive one quiz per day.

### Phrase Bank

A searchable library organizes Basic → Pro phrases by workplace, meetings,
email, interviews, social use, smart replies, grammar fixes, and advanced
upgrades. Free users can access 20 entries; Pro unlocks the full library.

### Streaks And Coins

Activities award coins and maintain the daily streak. Coins can purchase a
streak freeze or unlock selected phrase categories.

## Subscription

- Free: product limits listed above.
- Monthly: $4.99.
- Yearly: $39.99.
- Lifetime: $59.99.

Pro unlocks unlimited core usage, the full phrase bank, phrase pronunciation,
and quiz history.

## Technical Direction

- Flutter for iOS and Android.
- Supabase Auth, Postgres, Storage, and Edge Functions.
- Gemini for writing and situation coaching.
- Speechace for pronunciation.
- RevenueCat for subscriptions.

The canonical schema includes `upgrade_cards`, `user_card_progress`,
`phrase_bank`, `situation_scenarios`, `situation_sessions`, `quiz_questions`,
and `quiz_attempts`. The server must enforce free limits; the client must not be
the source of truth for usage or rewards.

## Build Order

1. Foundation, auth, and domain-aware onboarding.
2. Daily Upgrade Card vertical slice.
3. Situation Coach.
4. Writing Upgrade and pronunciation.
5. Quiz and Phrase Bank.
6. Progress, paywall, notifications, and analytics.
7. Production Supabase deployment and end-to-end testing.

The full source brief is `Vocly_PRD_v2.0.md` supplied by the product owner. Its
feature definitions and product rules take precedence over older documentation.
