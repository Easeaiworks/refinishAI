/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  experimental: {
    runtime: 'nodejs',
  },
}

module.exports = nextConfig
