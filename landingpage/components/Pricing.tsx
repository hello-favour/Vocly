'use client'

import { motion } from 'framer-motion'
import { PRICING } from '@/lib/content'

export default function Pricing() {
  return (
    <section className="px-6 py-24" id="pricing">
      <div className="mx-auto max-w-5xl">
        <div className="mb-16 text-center">
          <span className="mb-4 block text-sm font-medium uppercase tracking-widest text-brand-light">
            Pricing
          </span>
          <h2 className="mb-4 font-heading text-4xl font-semibold leading-tight text-ink md:text-5xl">
            Start free. Upgrade when you&apos;re ready.
          </h2>
          <p className="text-ink/50">No credit card required to get started.</p>
        </div>
        <div className="grid items-start gap-6 md:grid-cols-3">
          {PRICING.map((plan, i) => (
            <motion.div
              key={plan.name}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.1 }}
              className={`relative flex flex-col rounded-2xl border p-6 ${
                plan.highlight
                  ? 'border-brand/45 bg-brand/12 shadow-xl shadow-brand/10'
                  : 'border-border bg-card'
              }`}
            >
              {plan.badge && (
                <span className="absolute -top-3 left-1/2 -translate-x-1/2 rounded-full bg-brand px-4 py-1 text-xs font-medium text-white">
                  {plan.badge}
                </span>
              )}
              <div className="mb-5">
                <div className="mb-2 text-sm text-ink/50">{plan.name}</div>
                <div className="flex items-baseline gap-1">
                  <span className="font-heading text-4xl font-semibold text-ink">
                    {plan.price}
                  </span>
                  <span className="text-sm text-ink/40">/{plan.period}</span>
                </div>
                {plan.sub && (
                  <div className="mt-1 text-xs text-brand-light">{plan.sub}</div>
                )}
                <div className="mt-1 text-xs text-ink/40">
                  {plan.description}
                </div>
              </div>
              <ul className="mb-6 flex-1 space-y-3">
                {plan.features.map((feature) => (
                  <li
                    key={feature}
                    className="flex items-start gap-2 text-sm text-ink/60"
                  >
                    <span className="mt-0.5 flex-shrink-0 text-xs text-success">
                      ✓
                    </span>
                    {feature}
                  </li>
                ))}
              </ul>
              <a
                href={plan.ctaHref}
                className={`block rounded-xl py-3 text-center text-sm font-semibold transition-all ${
                  plan.highlight
                    ? 'bg-brand text-white shadow-lg shadow-brand/25 hover:bg-brand/90'
                    : 'border border-border text-ink/70 hover:border-border hover:text-ink'
                }`}
              >
                {plan.cta}
              </a>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
