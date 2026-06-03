'use client'

import Link from 'next/link'
import { useEffect, useState } from 'react'
import { APP_NAME, APP_STORE_URL } from '@/lib/content'

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    const handler = () => setScrolled(window.scrollY > 20)
    handler()
    window.addEventListener('scroll', handler)
    return () => window.removeEventListener('scroll', handler)
  }, [])

  return (
    <nav
      className={`fixed left-0 right-0 top-0 z-50 transition-all duration-300 ${
        scrolled
          ? 'border-b border-border bg-base/90 backdrop-blur-md'
          : 'bg-transparent'
      }`}
    >
      <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-6">
        <Link href="/" className="font-heading text-xl font-semibold text-ink">
          {APP_NAME}
        </Link>

        <div className="hidden items-center gap-8 md:flex">
          <Link
            href="#features"
            className="text-sm text-ink/50 transition-colors hover:text-ink"
          >
            Features
          </Link>
          <Link
            href="#how-it-works"
            className="text-sm text-ink/50 transition-colors hover:text-ink"
          >
            How it works
          </Link>
          <Link
            href="#pricing"
            className="text-sm text-ink/50 transition-colors hover:text-ink"
          >
            Pricing
          </Link>
        </div>

        <a
          href={APP_STORE_URL}
          className="rounded-xl bg-brand px-5 py-2 text-sm font-medium text-white transition-all hover:bg-brand/90"
        >
          Download app
        </a>
      </div>
    </nav>
  )
}
