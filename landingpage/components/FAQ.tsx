'use client'

import { AnimatePresence, motion } from 'framer-motion'
import { ChevronDown } from 'lucide-react'
import { useState } from 'react'
import { FAQS } from '@/lib/content'

export default function FAQ() {
  const [open, setOpen] = useState<number | null>(null)

  return (
    <section className="px-6 py-24">
      <div className="mx-auto max-w-2xl">
        <div className="mb-14 text-center">
          <h2 className="font-heading text-4xl font-semibold text-ink">
            Questions & answers
          </h2>
        </div>
        <div className="space-y-3">
          {FAQS.map((faq, i) => (
            <div
              key={faq.q}
              className="overflow-hidden rounded-xl border border-border"
            >
              <button
                onClick={() => setOpen(open === i ? null : i)}
                className="flex w-full items-center justify-between gap-4 px-5 py-4 text-left transition-colors hover:bg-card-selected"
              >
                <span className="text-sm font-medium text-ink">{faq.q}</span>
                <ChevronDown
                  className={`h-4 w-4 flex-shrink-0 text-ink/40 transition-transform duration-200 ${
                    open === i ? 'rotate-180' : ''
                  }`}
                />
              </button>
              <AnimatePresence>
                {open === i && (
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{ height: 'auto', opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }}
                    transition={{ duration: 0.2 }}
                    className="overflow-hidden"
                  >
                    <div className="border-t border-border px-5 pb-4 text-sm leading-relaxed text-ink/50">
                      <div className="pt-3">{faq.a}</div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
