/** @type {import('next').NextConfig} */
const nextConfig = {
  // Exclude supabase functions from build
  webpack: (config, { isServer }) => {
    config.module.rules.push({
      test: /supabase[\\/]functions/,
      use: 'null-loader'
    })
    return config
  },
}

module.exports = nextConfig
