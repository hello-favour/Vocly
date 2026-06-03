'use client'

import { motion } from 'framer-motion'
import {
  APP_STORE_URL,
  DESCRIPTION,
  PLAY_STORE_URL,
  TAGLINE,
} from '@/lib/content'

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
        Now available on iOS & Android
      </motion.div>

      <motion.h1
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.1 }}
        className="relative z-10 mb-6 max-w-3xl font-heading text-5xl font-semibold leading-[1.1] text-ink md:text-7xl"
      >
        {TAGLINE}
      </motion.h1>

      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.2 }}
        className="relative z-10 mb-10 max-w-lg text-lg leading-relaxed text-ink/55 md:text-xl"
      >
        {DESCRIPTION}
      </motion.p>

      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.3 }}
        className="relative z-10 mb-16 flex flex-col gap-3 sm:flex-row"
      >
        <a
          href={APP_STORE_URL}
          className="group flex items-center justify-center gap-3 rounded-2xl bg-brand px-7 py-4 text-base font-semibold text-white shadow-lg shadow-brand/25 transition-all hover:bg-brand/90"
        >
          <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
            <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
          </svg>
          Download on iOS
        </a>
        <a
          href={PLAY_STORE_URL}
          className="flex items-center justify-center gap-3 rounded-2xl border border-border bg-card-selected px-7 py-4 text-base font-semibold text-ink transition-all hover:border-border hover:bg-card-selected"
        >
          <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
            <path d="M3 20.5v-17c0-.83.94-1.3 1.6-.8l14 8.5c.6.37.6 1.23 0 1.6l-14 8.5c-.66.5-1.6.03-1.6-.8z" />
          </svg>
          Get it on Android
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
            <div className="flex h-full flex-col items-center gap-3 px-4 pb-16 pt-12">
              <div className="flex h-12 w-12 items-center justify-center rounded-2xl border border-brand/40 bg-brand/30">
                <span className="text-xl text-brand">V</span>
              </div>
              <span className="font-heading text-base font-semibold text-ink">
                Vocly
              </span>
              <div className="w-full rounded-xl border border-border bg-card-selected p-3 text-left">
                <div className="mb-1 text-[9px] text-brand-light">
                  Word of the day
                </div>
                <div className="font-heading text-lg text-ink">Articulate</div>
                <div className="mt-1 text-[9px] text-ink/40">
                  Express ideas clearly and effectively
                </div>
              </div>
              <div className="grid w-full grid-cols-2 gap-2">
                <div className="rounded-xl border border-success/20 bg-success/10 p-3 text-left">
                  <div className="text-[9px] text-success">Writing</div>
                  <div className="mt-1 text-sm font-semibold text-ink">86</div>
                </div>
                <div className="rounded-xl border border-warning/20 bg-warning/10 p-3 text-left">
                  <div className="text-[9px] text-warning">Speech</div>
                  <div className="mt-1 text-sm font-semibold text-ink">92</div>
                </div>
              </div>
              <div className="h-1 w-full overflow-hidden rounded-full bg-brand/20">
                <div className="h-full w-3/4 rounded-full bg-brand" />
              </div>
            </div>
          </div>
        </div>
      </motion.div>
    </section>
  )
}
