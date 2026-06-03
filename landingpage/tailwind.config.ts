import type { Config } from 'tailwindcss'

const config: Config = {
  content: ['./app/**/*.{ts,tsx}', './components/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        base: '#FFFCFA',
        deep: '#F8EEF1',
        ink: '#241218',
        surface: '#FFFFFF',
        card: '#FFFFFF',
        'card-selected': '#FFEEF3',
        border: 'rgba(109,16,40,0.12)',
        'border-selected': 'rgba(109,16,40,0.8)',
        brand: '#6D1028',
        'brand-light': '#9F2445',
        'brand-dim': 'rgba(109,16,40,0.14)',
        accent: '#C99045',
        success: '#13865E',
        warning: '#C99045',
        danger: '#D64045',
        info: '#7C4D8E',
      },
      fontFamily: {
        heading: ['var(--font-lora)', 'Georgia', 'serif'],
        body: ['var(--font-dm-sans)', 'system-ui', 'sans-serif'],
      },
      backgroundImage: {
        'glow-radial':
          'radial-gradient(ellipse 80% 50% at 50% -20%, rgba(109,16,40,0.16), transparent)',
        'glow-bottom':
          'radial-gradient(ellipse 60% 40% at 50% 110%, rgba(201,144,69,0.18), transparent)',
        'card-gradient':
          'linear-gradient(135deg, rgba(109,16,40,0.08), rgba(201,144,69,0.08))',
      },
      animation: {
        'pulse-slow': 'pulse 3s ease-in-out infinite',
      },
    },
  },
  plugins: [],
}

export default config
