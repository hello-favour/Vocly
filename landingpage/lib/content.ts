export const APP_NAME = 'Vocly'
export const TAGLINE = 'Speak English like you mean it'
export const DESCRIPTION =
  'A daily English communication coach in your pocket. Improve your writing, pronunciation, and confidence - in just 10 minutes a day.'

export const APP_STORE_URL = '#'
export const PLAY_STORE_URL = '#'
export const WAITLIST_URL = '#'

export const SOCIAL_PROOF = [
  { number: '1.5B+', label: 'non-native English speakers globally' },
  { number: '$9.2B', label: 'English learning market in 2025' },
  { number: '10 min', label: 'daily practice to see real improvement' },
]

export const PAINS = [
  {
    icon: '💼',
    title: 'You freeze in meetings',
    body: 'You know exactly what you want to say - but the words come out wrong or not at all. Your ideas get overlooked.',
  },
  {
    icon: '✉️',
    title: 'Your emails sound off',
    body: 'You re-read every email five times before sending. Is it professional enough? Does it sound natural? It slows you down.',
  },
  {
    icon: '😔',
    title: 'You feel less capable than you are',
    body: "You're highly intelligent - but the language gap makes you seem less confident than your actual ability.",
  },
]

export const FEATURES = [
  {
    icon: '📖',
    tag: 'Daily lessons',
    title: 'One lesson every day',
    body: 'A new word, phrase, and grammar tip - chosen for real-world professional situations, not textbook exercises.',
    color: 'brand',
  },
  {
    icon: '✍️',
    tag: 'AI writing check',
    title: 'Paste any sentence. Get instant feedback.',
    body: 'The AI corrects your grammar, flags unclear phrasing, rates your tone, and gives you a better version. In seconds.',
    color: 'success',
  },
  {
    icon: '🎙️',
    tag: 'Pronunciation scoring',
    title: 'Record yourself. Know if you said it right.',
    body: 'Hear the correct pronunciation, record yourself, and get a score. No more guessing before your next meeting.',
    color: 'warning',
  },
]

export const STEPS = [
  {
    number: '01',
    title: 'Complete your daily lesson',
    body: 'Swipe through a new word, phrase, and grammar rule. Takes 3 minutes.',
  },
  {
    number: '02',
    title: 'Check your writing with AI',
    body: 'Paste any email, message, or sentence. Get instant corrections and a clarity score.',
  },
  {
    number: '03',
    title: 'Practice pronunciation',
    body: "Record yourself saying today's word. Get scored on every phoneme. Improve daily.",
  },
]

export const TESTIMONIALS = [
  {
    name: 'Emeka O.',
    role: 'Software Engineer, Lagos',
    avatar: 'EO',
    quote:
      'I used to re-read every email I sent three times. After two weeks with Vocly, I noticed I just... write and send. The confidence came faster than I expected.',
  },
  {
    name: 'Amara K.',
    role: 'Finance Analyst, Nairobi',
    avatar: 'AK',
    quote:
      "The AI writing check is what got me. I pasted an email I was about to send to my manager and it caught three things I didn't notice. Game changer.",
  },
  {
    name: 'Tunde B.',
    role: 'Product Manager, Accra',
    avatar: 'TB',
    quote:
      "I've tried Duolingo, Grammarly, everything. Vocly is the first one that actually feels like it was built for me - for the problems I actually have at work.",
  },
]

export const PRICING = [
  {
    name: 'Free',
    price: '$0',
    period: 'forever',
    description: 'Start building the habit',
    features: [
      '3 lessons per day',
      '5 AI writing checks per day',
      '3 pronunciation attempts per day',
      'Basic streak tracking',
    ],
    cta: 'Download free',
    ctaHref: APP_STORE_URL,
    highlight: false,
  },
  {
    name: 'Pro',
    price: '$39.99',
    period: 'per year',
    sub: 'Just $3.33/month',
    description: 'For serious improvement',
    features: [
      'Unlimited lessons',
      'Unlimited AI writing feedback',
      'Full pronunciation reports',
      'Streak freeze protection',
      'Progress history & analytics',
    ],
    cta: 'Get Pro yearly',
    ctaHref: APP_STORE_URL,
    highlight: true,
    badge: 'Best value',
  },
  {
    name: 'Lifetime',
    price: '$59.99',
    period: 'one time',
    description: 'Pay once, own forever',
    features: [
      'Everything in Pro',
      'All future features included',
      'Never pay again',
    ],
    cta: 'Get lifetime access',
    ctaHref: APP_STORE_URL,
    highlight: false,
  },
]

export const FAQS = [
  {
    q: 'Is Vocly for complete beginners?',
    a: 'Vocly works for all levels - beginner, intermediate, and advanced. During onboarding you pick your level and goal, and lessons are matched to you. Most users are intermediate speakers who want to sound more professional.',
  },
  {
    q: 'How is Vocly different from Duolingo or Grammarly?',
    a: "Duolingo teaches grammar like a game - it's great for beginners but doesn't address professional communication confidence. Grammarly corrects your writing passively but teaches you nothing. Vocly combines daily lessons, AI writing feedback, and pronunciation scoring in one habit-forming app built specifically for professional use.",
  },
  {
    q: 'How long does it take to see results?',
    a: 'Most users notice a difference in their writing within 7-14 days. Speaking confidence takes longer - usually 3-4 weeks of consistent daily practice. The key is the streak system: small daily sessions compound fast.',
  },
  {
    q: 'Is the AI feedback accurate?',
    a: "Yes. Vocly uses Gemini, Google's AI, for writing feedback - one of the most capable language models available. It's prompted specifically for English learners, not generic chatbot use.",
  },
  {
    q: 'Can I cancel my subscription anytime?',
    a: 'Yes. Cancel anytime from your phone settings. Your Pro access remains until the end of your billing period. No hidden fees, no complicated cancellation flows.',
  },
]

export const FOOTER_LINKS = [
  { label: 'Privacy', href: '/privacy' },
  { label: 'Terms', href: '/terms' },
  { label: 'Contact', href: 'mailto:hello@vocly.app' },
]
