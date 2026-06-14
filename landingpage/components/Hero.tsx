'use client'

import { motion } from 'framer-motion'
import { DESCRIPTION, TAGLINE, WAITLIST_URL } from '@/lib/content'

export default function Hero() {
  return (
    <section className="noise-overlay relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-6 pb-20 pt-24 text-center">
      <div className="absolute inset-0 bg-glow-radial" />

      <motion.div
        initial={{ opacity: 0, y: 16 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="relative z-10 mb-8 inline-flex items-center gap-2 rounded-full border border-brand/25 bg-brand/15 px-4 py-2 text-sm font-medium text-brand-light"
      >
        <span className="h-2 w-2 rounded-full bg-success animate-pulse-slow" />
        MVP coming soon to iOS & Android
      </motion.div>

      <motion.h1
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.1 }}
        className="relative z-10 mb-6 max-w-4xl font-heading text-5xl font-semibold leading-[1.1] text-ink md:text-7xl"
      >
        {TAGLINE}
      </motion.h1>

      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.2 }}
        className="relative z-10 mb-10 max-w-2xl text-lg leading-relaxed text-ink/55 md:text-xl"
      >
        {DESCRIPTION}
      </motion.p>

      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.3 }}
        className="relative z-10 mb-16"
      >
        <a
          href={WAITLIST_URL}
          className="group flex items-center justify-center gap-3 rounded-2xl bg-brand px-7 py-4 text-base font-semibold text-white shadow-lg shadow-brand/25 transition-all hover:bg-brand/90"
        >
          Join early access
        </a>
      </motion.div>

      <motion.div
        initial={{ opacity: 0, y: 40, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        transition={{ duration: 0.8, delay: 0.4 }}
        className="relative z-10 mx-auto w-full max-w-[280px]"
      >
        <div className="relative rounded-[40px] border border-brand/20 bg-brand p-2 shadow-2xl shadow-brand/25">
          <div className="aspect-[9/19.5] overflow-hidden rounded-[32px] bg-deep">
            <div className="flex h-8 items-center justify-between bg-brand px-6 pt-2">
              <span className="text-[9px] text-white/65">9:41</span>
              <span className="text-[9px] text-white/65">●●●</span>
            </div>
            <div className="flex h-full flex-col gap-3 px-4 pb-16 pt-8">
              <div className="flex items-center justify-between">
                <div>
                  <div className="text-[9px] text-ink/40">TODAY’S UPGRADE</div>
                  <div className="font-heading text-base font-semibold text-ink">
                    Speak like a pro
                  </div>
                </div>
                <div className="rounded-full bg-warning/15 px-2 py-1 text-[9px] text-warning">
                  1 day
                </div>
              </div>
              <div className="w-full rounded-xl border border-border bg-card p-4 text-left shadow-sm">
                <div className="mb-3 text-[9px] font-semibold uppercase tracking-wider text-brand-light">
                  Basic → Professional
                </div>
                <div className="text-[9px] font-semibold text-ink/35">BASIC</div>
                <div className="mt-1 font-heading text-base text-ink/45">
                  I’m very busy.
                </div>
                <div className="py-3 text-sm text-warning">↓</div>
                <div className="text-[9px] font-semibold text-brand-light">
                  SAY THIS
                </div>
                <div className="mt-1 font-heading text-xl font-semibold text-brand">
                  I’m swamped.
                </div>
              </div>
              <div className="w-full rounded-xl border border-border bg-card p-3">
                <div className="mb-2 text-[9px] text-ink/40">
                  PRACTISE SPEAKING
                </div>
                <div className="flex items-center gap-3">
                  <div className="flex h-10 w-10 items-center justify-center rounded-full bg-brand text-sm text-white">
                    ●
                  </div>
                  <div className="text-left">
                    <div className="text-[10px] font-medium text-ink">
                      Say “I’m swamped”
                    </div>
                    <div className="text-[9px] text-ink/35">
                      Tap to record your voice
                    </div>
                  </div>
                </div>
              </div>
              <div className="mt-auto flex w-full justify-around border-t border-border pt-3 text-[9px] text-ink/35">
                <span className="font-semibold text-brand">Home</span>
                <span>Speak</span>
                <span>Profile</span>
              </div>
            </div>
          </div>
        </div>
      </motion.div>
    </section>
  )
}
