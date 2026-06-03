import Link from 'next/link'
import { APP_NAME, FOOTER_LINKS } from '@/lib/content'

export default function Footer() {
  return (
    <footer className="border-t border-border px-6 py-10">
      <div className="mx-auto flex max-w-5xl flex-col items-center justify-between gap-4 md:flex-row">
        <span className="font-heading text-lg font-semibold text-ink">
          {APP_NAME}
        </span>
        <div className="flex gap-6 text-sm text-ink/40">
          {FOOTER_LINKS.map((link) =>
            link.href.startsWith('mailto:') ? (
              <a
                key={link.label}
                href={link.href}
                className="transition-colors hover:text-ink"
              >
                {link.label}
              </a>
            ) : (
              <Link
                key={link.label}
                href={link.href}
                className="transition-colors hover:text-ink"
              >
                {link.label}
              </Link>
            ),
          )}
        </div>
        <span className="text-sm text-ink/25">
          © {new Date().getFullYear()} Vocly. All rights reserved.
        </span>
      </div>
    </footer>
  )
}
