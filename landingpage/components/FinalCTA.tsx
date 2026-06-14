import { WAITLIST_URL } from '@/lib/content'

export default function FinalCTA() {
  return (
    <section className="relative overflow-hidden px-6 py-24">
      <div className="absolute inset-0 bg-glow-radial opacity-60" />
      <div className="relative z-10 mx-auto max-w-3xl text-center">
        <h2 className="mb-6 font-heading text-4xl font-semibold leading-tight text-ink md:text-6xl">
          Sound more confident in your next conversation.
        </h2>
        <p className="mx-auto mb-10 max-w-xl text-lg leading-relaxed text-ink/55">
          Learn one stronger phrase, understand where it fits, and practise
          saying it aloud.
        </p>
        <div className="flex flex-col justify-center gap-3 sm:flex-row">
          <a
            href={WAITLIST_URL}
            className="rounded-2xl bg-brand px-8 py-4 text-base font-semibold text-white shadow-xl shadow-brand/25 transition-all hover:bg-brand/90"
          >
            Join early access
          </a>
        </div>
        <p className="mt-6 text-sm text-ink/25">
          Coming soon to iOS and Android.
        </p>
      </div>
    </section>
  )
}
