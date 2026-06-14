export const APP_NAME = 'Vocly'
export const TAGLINE = 'Stop sounding basic. Start speaking like a pro.'
export const DESCRIPTION =
  'Vocly helps people who already speak English sound more natural, confident, and professional - one useful phrase at a time.'

export const WAITLIST_URL = '#'

export const PAINS = [
  {
    icon: '→',
    title: 'You know what you mean',
    body: 'But the first phrase that comes to mind can sound basic, awkward, or too direct.',
  },
  {
    icon: '→',
    title: 'Textbook English is not enough',
    body: 'Correct English can still sound unnatural in meetings, interviews, and everyday conversations.',
  },
  {
    icon: '→',
    title: 'Confidence comes from practice',
    body: 'It is easier to speak clearly when you already know the right phrase and have practised saying it.',
  },
]

export const FEATURES = [
  {
    icon: '01',
    tag: 'Home',
    title: 'Upgrade basic English',
    body: 'See the phrase you might normally use beside a more natural, confident, professional version.',
    color: 'brand',
  },
  {
    icon: '02',
    tag: 'Speak',
    title: 'Practise the pro phrase',
    body: 'Say today’s upgraded phrase aloud and receive a pronunciation score so you can try again with confidence.',
    color: 'success',
  },
  {
    icon: '03',
    tag: 'Daily habit',
    title: 'Improve one phrase at a time',
    body: 'Keep a simple streak and build a collection of expressions you can actually use in real conversations.',
    color: 'warning',
  },
]

export const STEPS = [
  {
    number: '01',
    title: 'See the upgrade',
    body: 'Learn a better way to express something you already know how to say.',
  },
  {
    number: '02',
    title: 'Understand the context',
    body: 'See when the phrase sounds natural, when to avoid it, and how it works in conversation.',
  },
  {
    number: '03',
    title: 'Say it out loud',
    body: 'Practise the professional phrase, get a score, and repeat until it feels natural.',
  },
]

export const PRICING = [
  {
    name: 'Free',
    price: '$0',
    period: 'forever',
    description: 'Start speaking with more confidence',
    features: [
      '3 daily phrase upgrades',
      '3 speaking attempts per day',
      'Simple daily streak',
    ],
    cta: 'Join early access',
    ctaHref: WAITLIST_URL,
    highlight: false,
  },
  {
    name: 'Vocly Pro',
    price: '$4.99',
    period: 'month',
    sub: 'Yearly and lifetime options will also be available',
    description: 'Practise without daily limits',
    features: [
      'Unlimited phrase upgrades',
      'Unlimited speaking practice',
      'Access to every professional phrase',
    ],
    cta: 'Join early access',
    ctaHref: WAITLIST_URL,
    highlight: true,
    badge: 'For daily practice',
  },
]

export const FAQS = [
  {
    q: 'Who is Vocly for?',
    a: 'Vocly is for people who already speak English but want to sound more natural, confident, and professional. It is especially useful for work, interviews, and everyday conversations.',
  },
  {
    q: 'Is Vocly for complete beginners?',
    a: 'No. Vocly does not teach English from the beginning. It helps existing English speakers upgrade the way they express themselves.',
  },
  {
    q: 'What does a daily upgrade look like?',
    a: 'Vocly shows a basic phrase and a stronger alternative, explains where it fits, gives real examples, and lets you practise saying it aloud.',
  },
  {
    q: 'Does Vocly teach grammar or writing?',
    a: 'The MVP is focused on one problem: helping you speak more naturally and professionally. Writing tools and broader lessons are not part of the current version.',
  },
  {
    q: 'When will Vocly be available?',
    a: 'Vocly is currently being prepared for its first release on iOS and Android. Join early access to hear when it is ready.',
  },
]

export const FOOTER_LINKS = [
  { label: 'Privacy', href: '/privacy' },
  { label: 'Terms', href: '/terms' },
  { label: 'Contact', href: 'mailto:hello@vocly.app' },
]
