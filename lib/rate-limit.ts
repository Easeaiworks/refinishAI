import { NextRequest, NextResponse } from 'next/server'

interface RateLimitConfig {
  /** Maximum requests allowed in the window */
  maxRequests: number
  /** Time window in seconds */
  windowSeconds: number
  /** Identifier for the rate limit bucket (e.g., 'api', 'auth', 'webhook') */
  prefix?: string
}

interface RateLimitResult {
  allowed: boolean
  remaining: number
  resetAt: number
}

// In-memory rate limiting store (works in Edge Runtime and Node.js)
const memoryStore = new Map<string, { count: number; resetAt: number }>()

// Clean up expired entries periodically
let cleanupScheduled = false

function scheduleCleanup() {
  if (cleanupScheduled) return
  cleanupScheduled = true
  setTimeout(() => {
    cleanupScheduled = false
    const now = Date.now()
    memoryStore.forEach((value, key) => {
      if (value.resetAt <= now) {
        memoryStore.delete(key)
      }
    })
  }, 60_000)
}

/**
 * Check rate limit for an identifier (usually IP address).
 * Uses in-memory store (works everywhere including Edge Runtime).
 */
export async function checkRateLimit(
  identifier: string,
  config: RateLimitConfig
): Promise<RateLimitResult> {
  const { maxRequests, windowSeconds, prefix = 'rl' } = config
  const key = `${prefix}:${identifier}`

  scheduleCleanup()
  const now = Date.now()
  const entry = memoryStore.get(key)

  if (!entry || entry.resetAt <= now) {
    // New window
    const resetAt = now + windowSeconds * 1000
    memoryStore.set(key, { count: 1, resetAt })
    return { allowed: true, remaining: maxRequests - 1, resetAt }
  }

  // Increment existing window
  entry.count++
  const allowed = entry.count <= maxRequests

  return {
    allowed,
    remaining: Math.max(0, maxRequests - entry.count),
    resetAt: entry.resetAt,
  }
}

/**
 * Get the client IP from a request.
 */
export function getClientIp(request: NextRequest): string {
  return (
    request.headers.get('x-forwarded-for')?.split(',')[0]?.trim() ||
    request.headers.get('x-real-ip') ||
    request.ip ||
    'unknown'
  )
}

/**
 * Rate-limit middleware helper — returns a 429 response if rate exceeded.
 * Returns null if the request is allowed.
 */
export async function rateLimitResponse(
  request: NextRequest,
  config: RateLimitConfig
): Promise<NextResponse | null> {
  const ip = getClientIp(request)
  const result = await checkRateLimit(ip, config)

  if (!result.allowed) {
    return NextResponse.json(
      { error: 'Too many requests. Please try again later.' },
      {
        status: 429,
        headers: {
          'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
          'X-RateLimit-Limit': String(config.maxRequests),
          'X-RateLimit-Remaining': '0',
          'X-RateLimit-Reset': String(Math.ceil(result.resetAt / 1000)),
        },
      }
    )
  }

  return null
}
