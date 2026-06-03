'use client'

import { motion } from 'framer-motion'
import { TESTIMONIALS } from '@/lib/content'

export default function Testimonials() {
  return (
    <section className="px-6 py-24">
      <div className="mx-auto max-w-5xl">
        <div className="mb-16 text-center">
          <h2 className="font-heading text-4xl font-semibold leading-tight text-ink md:text-5xl">
            Real people. Real results.
          </h2>
        </div>
        <div className="grid gap-6 md:grid-cols-3">
          {TESTIMONIALS.map((testimonial, i) => (
            <motion.div
              key={testimonial.name}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.1 }}
              className="rounded-2xl border border-border bg-card p-6"
            >
              <div className="mb-4 flex gap-1">
                {Array.from({ length: 5 }).map((_, starIndex) => (
                  <span key={starIndex} className="text-sm text-warning">
                    ★
                  </span>
                ))}
              </div>
              <p className="mb-6 text-sm italic leading-relaxed text-ink/70">
                &quot;{testimonial.quote}&quot;
              </p>
              <div className="flex items-center gap-3">
                <div className="flex h-9 w-9 flex-shrink-0 items-center justify-center rounded-full border border-brand/40 bg-brand/30 text-xs font-semibold text-brand-light">
                  {testimonial.avatar}
                </div>
                <div>
                  <div className="text-sm font-medium text-ink">
                    {testimonial.name}
                  </div>
                  <div className="text-xs text-ink/40">{testimonial.role}</div>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
