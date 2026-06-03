import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  metadataBase: new URL('https://vocly.app'),
  title: 'Vocly - Speak English like you mean it',
  description:
    'A daily English communication coach in your pocket. Improve your writing, pronunciation, and confidence in 10 minutes a day.',
  keywords: [
    'English learning',
    'communication app',
    'pronunciation',
    'grammar',
    'vocabulary',
    'non-native speakers',
  ],
  openGraph: {
    title: 'Vocly - Speak English like you mean it',
    description:
      'Daily lessons, AI writing feedback, and pronunciation scoring for non-native English speakers.',
    url: 'https://vocly.app',
    siteName: 'Vocly',
    images: [{ url: '/og-image.png', width: 1200, height: 630 }],
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Vocly - Speak English like you mean it',
    description: 'Daily lessons, AI writing feedback, and pronunciation scoring.',
    images: ['/og-image.png'],
  },
  icons: { icon: '/favicon.ico' },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className="overflow-x-hidden bg-base font-body text-ink antialiased">
        {children}
      </body>
    </html>
  )
}
