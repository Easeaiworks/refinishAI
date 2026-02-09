import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'
import { checkRateLimit, getClientIp } from '@/lib/rate-limit'

// Routes that do NOT require authentication — skip Supabase auth call
const PUBLIC_ROUTES = [
  '/',
  '/login',
  '/signup',
  '/auth/callback',
  '/auth/confirm',
  '/privacy',
  '/terms',
  '/api/stripe/webhooks', // Stripe verifies its own signatures
]

// Routes that get stricter rate limiting (sensitive endpoints)
const STRICT_RATE_LIMIT_ROUTES = [
  '/api/stripe/checkout',
  '/login',
  '/signup',
  '/auth/',
]

/**
 * Check if a pathname matches any of the given route prefixes.
 */
function matchesRoute(pathname: string, routes: string[]): boolean {
  return routes.some(route => pathname === route || pathname.startsWith(route + '/'))
}

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl

  // ───────────────────────────────────────────────
  // 1. Rate limiting for API routes
  // ───────────────────────────────────────────────
  if (pathname.startsWith('/api/')) {
    // Skip rate limiting for Stripe webhooks (Stripe has its own retry logic)
    if (pathname !== '/api/stripe/webhooks') {
      const isStrict = matchesRoute(pathname, STRICT_RATE_LIMIT_ROUTES)
      const ip = getClientIp(request)
      const result = await checkRateLimit(ip, {
        maxRequests: isStrict ? 10 : 60,     // 10 req/min for sensitive, 60 for general
        windowSeconds: 60,
        prefix: isStrict ? 'rl:strict' : 'rl:api',
      })

      if (!result.allowed) {
        return NextResponse.json(
          { error: 'Too many requests. Please try again later.' },
          {
            status: 429,
            headers: {
              'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
              'X-RateLimit-Limit': String(isStrict ? 10 : 60),
              'X-RateLimit-Remaining': '0',
              'X-RateLimit-Reset': String(Math.ceil(result.resetAt / 1000)),
            },
          }
        )
      }
    }
  }

  // ───────────────────────────────────────────────
  // 2. Skip auth for public routes (saves a DB call per request)
  // ───────────────────────────────────────────────
  if (matchesRoute(pathname, PUBLIC_ROUTES)) {
    return NextResponse.next()
  }

  // ───────────────────────────────────────────────
  // 3. Auth session refresh for protected routes
  // ───────────────────────────────────────────────
  let response = NextResponse.next({
    request: {
      headers: request.headers,
    },
  })

  // Use dummy values during build if env vars are missing
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co'
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder-key'

  const supabase = createServerClient(supabaseUrl, supabaseKey, {
    cookies: {
      getAll() {
        return request.cookies.getAll()
      },
      setAll(cookiesToSet: { name: string; value: string; options?: any }[]) {
        cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value))
        response = NextResponse.next({
          request,
        })
        cookiesToSet.forEach(({ name, value, options }) =>
          response.cookies.set(name, value, options)
        )
      },
    },
  })

  // Only call getUser for protected routes (this is the expensive DB call)
  const { data: { user } } = await supabase.auth.getUser()

  // If user is not authenticated and trying to access dashboard, redirect to login
  if (!user && pathname.startsWith('/dashboard')) {
    const loginUrl = new URL('/login', request.url)
    loginUrl.searchParams.set('redirect', pathname)
    return NextResponse.redirect(loginUrl)
  }

  return response
}

export const config = {
  matcher: [
    /*
     * Match all request paths except:
     * - _next/static (static files)
     * - _next/image (image optimization)
     * - favicon.ico
     * - Static assets (svg, png, jpg, etc.)
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico)$).*)',
  ],
}
