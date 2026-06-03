'use client'

import { motion } from 'framer-motion'
import { PAINS } from '@/lib/content'

export default function Problem() {
  return (
    <section className="px-6 py-24">
      <div className="mx-auto max-w-5xl">
        <div className="mb-16 text-center">
          <span className="mb-4 block text-sm font-medium uppercase tracking-widest text-brand-light">
            The problem
          </span>
          <h2 className="mx-auto mb-6 max-w-2xl font-heading text-4xl font-semibold leading-tight text-ink md:text-5xl">
            You know English. You just don&apos;t{' '}
            <em className="not-italic text-brand-light">sound like it yet.</em>
          </h2>
          <p className="mx-auto max-w-xl text-lg leading-relaxed text-ink/50">
            1.5 billion people speak English as a second language. Most
            struggle not with the rules - but with confidence and clarity in
            real situations.
          </p>
        </div>

        <div className="grid gap-6 md:grid-cols-3">
          {PAINS.map((pain, i) => (
            <motion.div
              key={pain.title}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.1 }}
              className="rounded-2xl border border-border bg-card p-6 transition-colors hover:bg-card-selected"
            >
              <div className="mb-5 text-4xl">{pain.icon}</div>
              <h3 className="mb-3 font-heading text-lg font-semibold text-ink">
                {pain.title}
              </h3>
              <p className="text-sm leading-relaxed text-ink/50">
                {pain.body}
              </p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
