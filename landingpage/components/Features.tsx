'use client'

import { motion } from 'framer-motion'
import { FEATURES } from '@/lib/content'

const colorMap: Record<string, string> = {
  brand: 'border-brand/30 bg-brand/10 text-brand-light',
  success: 'border-success/30 bg-success/10 text-success',
  warning: 'border-warning/30 bg-warning/10 text-warning',
}

const textMap: Record<string, string> = {
  brand: 'text-brand-light',
  success: 'text-success',
  warning: 'text-warning',
}

export default function Features() {
  return (
    <section className="relative px-6 py-24" id="features">
      <div className="absolute inset-0 bg-glow-bottom" />
      <div className="relative z-10 mx-auto max-w-5xl">
        <div className="mb-16 text-center">
          <span className="mb-4 block text-sm font-medium uppercase tracking-widest text-brand-light">
            The MVP
          </span>
          <h2 className="mx-auto max-w-2xl font-heading text-4xl font-semibold leading-tight text-ink md:text-5xl">
            One focused app. One clear outcome.
          </h2>
        </div>

        <div className="space-y-6">
          {FEATURES.map((feature, i) => (
            <motion.div
              key={feature.title}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.1 }}
              className="flex flex-col items-start gap-6 rounded-2xl border border-border bg-card p-7 transition-colors hover:bg-card-selected md:flex-row"
            >
              <div
                className={`flex h-14 w-14 flex-shrink-0 items-center justify-center rounded-2xl border text-2xl ${
                  colorMap[feature.color]
                }`}
              >
                {feature.icon}
              </div>
              <div className="flex-1">
                <span
                  className={`mb-2 block text-xs font-medium uppercase tracking-widest ${
                    textMap[feature.color]
                  }`}
                >
                  {feature.tag}
                </span>
                <h3 className="mb-2 font-heading text-xl font-semibold text-ink">
                  {feature.title}
                </h3>
                <p className="text-base leading-relaxed text-ink/50">
                  {feature.body}
                </p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
