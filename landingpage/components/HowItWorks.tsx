'use client'

import { motion } from 'framer-motion'
import { STEPS } from '@/lib/content'

export default function HowItWorks() {
  return (
    <section className="px-6 py-24" id="how-it-works">
      <div className="mx-auto max-w-4xl">
        <div className="mb-16 text-center">
          <span className="mb-4 block text-sm font-medium uppercase tracking-widest text-brand-light">
            How it works
          </span>
          <h2 className="font-heading text-4xl font-semibold leading-tight text-ink md:text-5xl">
            Learn it. Understand it. Say it.
          </h2>
        </div>

        <div className="grid gap-8 md:grid-cols-3">
          {STEPS.map((step, i) => (
            <motion.div
              key={step.number}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.15 }}
              className="relative text-center"
            >
              {i < STEPS.length - 1 && (
                <div className="absolute left-[60%] top-8 hidden h-px w-full bg-gradient-to-r from-brand/40 to-transparent md:block" />
              )}
              <div className="mx-auto mb-5 flex h-16 w-16 items-center justify-center rounded-2xl border border-brand/25 bg-brand/15">
                <span className="font-heading text-2xl font-semibold text-brand-light">
                  {step.number}
                </span>
              </div>
              <h3 className="mb-3 font-heading text-lg font-semibold text-ink">
                {step.title}
              </h3>
              <p className="text-sm leading-relaxed text-ink/50">
                {step.body}
              </p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
