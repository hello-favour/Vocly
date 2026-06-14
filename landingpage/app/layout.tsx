import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  metadataBase: new URL('https://vocly.app'),
  title: 'Vocly - Speak Like a Pro',
  description:
    'Upgrade basic English into natural, confident, professional phrases and practise saying them aloud.',
  keywords: [
    'professional English',
    'spoken English',
    'pronunciation',
    'English phrases',
    'speaking confidence',
    'non-native speakers',
  ],
  openGraph: {
    title: 'Vocly - Speak Like a Pro',
    description:
      'Turn basic English into natural, confident, professional speech.',
    url: 'https://vocly.app',
    siteName: 'Vocly',
    images: [{ url: '/og-image.png', width: 1200, height: 630 }],
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Vocly - Speak Like a Pro',
    description: 'Upgrade your phrases and practise speaking them with confidence.',
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
