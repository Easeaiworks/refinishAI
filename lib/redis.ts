import Redis from 'ioredis'

let redis: Redis | null = null

/**
 * Get the Redis client instance (singleton).
 * Returns null if REDIS_URL is not configured — all callers
 * must handle the null case gracefully (fall back to direct DB).
 */
export function getRedis(): Redis | null {
  if (redis) return redis

  const url = process.env.REDIS_URL
  if (!url) {
    return null
  }

  redis = new Redis(url, {
    maxRetriesPerRequest: 3,
    retryStrategy(times: number) {
      if (times > 3) return null // Stop retrying after 3 attempts
      return Math.min(times * 200, 2000) // Exponential backoff
    },
    lazyConnect: true,
    connectTimeout: 5000,
  })

  redis.on('error', (err: Error) => {
    console.error('Redis connection error:', err.message)
  })

  return redis
}

/**
 * Cache helper — get from cache, or fetch from source and cache.
 * Falls back to fetchFn directly if Redis is unavailable.
 */
export async function cached<T>(
  key: string,
  fetchFn: () => Promise<T>,
  ttlSeconds: number = 300 // 5 minute default
): Promise<T> {
  const client = getRedis()

  if (client) {
    try {
      const hit = await client.get(key)
      if (hit) {
        return JSON.parse(hit) as T
      }
    } catch {
      // Redis read failed — fall through to fetchFn
    }
  }

  const data = await fetchFn()

  if (client && data !== null && data !== undefined) {
    try {
      await client.setex(key, ttlSeconds, JSON.stringify(data))
    } catch {
      // Redis write failed — data still returned from fetchFn
    }
  }

  return data
}

/**
 * Invalidate a cache key or pattern.
 */
export async function invalidateCache(pattern: string): Promise<void> {
  const client = getRedis()
  if (!client) return

  try {
    if (pattern.includes('*')) {
      const keys = await client.keys(pattern)
      if (keys.length > 0) {
        await client.del(...keys)
      }
    } else {
      await client.del(pattern)
    }
  } catch {
    // Silently fail — cache invalidation is best-effort
  }
}
