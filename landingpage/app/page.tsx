import FAQ from '@/components/FAQ'
import Features from '@/components/Features'
import FinalCTA from '@/components/FinalCTA'
import Footer from '@/components/Footer'
import Hero from '@/components/Hero'
import HowItWorks from '@/components/HowItWorks'
import Navbar from '@/components/Navbar'
import Pricing from '@/components/Pricing'
import Problem from '@/components/Problem'

export default function Home() {
  return (
    <>
      <Navbar />
      <main>
        <Hero />
        <Problem />
        <Features />
        <HowItWorks />
        <Pricing />
        <FAQ />
        <FinalCTA />
      </main>
      <Footer />
    </>
  )
}
