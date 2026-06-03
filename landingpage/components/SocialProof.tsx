import { SOCIAL_PROOF } from '@/lib/content'

export default function SocialProof() {
  return (
    <section className="border-y border-border py-12">
      <div className="mx-auto max-w-4xl px-6">
        <div className="grid grid-cols-1 gap-8 text-center sm:grid-cols-3 sm:gap-6">
          {SOCIAL_PROOF.map((item) => (
            <div key={item.label}>
              <div className="mb-1 font-heading text-3xl font-semibold text-ink md:text-4xl">
                {item.number}
              </div>
              <div className="text-sm text-ink/40">{item.label}</div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
