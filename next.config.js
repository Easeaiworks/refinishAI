/** @type {import('next').NextConfig} */
const nextConfig = {
  typescript: {
    // Ignore build errors in supabase functions
    ignoreBuildErrors: false,
  },
  // Exclude supabase functions from build
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = {
        ...config.resolve.fallback,
        fs: false,
      }
    }
    
    // Exclude supabase functions directory
    config.module.rules.push({
      test: /supabase\/functions/,
      loader: 'ignore-loader'
    })
    
    return config
  },
}

module.exports = nextConfig
