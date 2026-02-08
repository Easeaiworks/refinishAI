export default function DashboardLoading() {
  return (
    <div className="space-y-6 animate-pulse">
      {/* Banner Skeleton */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="bg-slate-200 h-32"></div>
      </div>

      {/* Stats Cards Skeleton */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {[...Array(4)].map((_, i) => (
          <div key={i} className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
            <div className="p-5">
              <div className="space-y-3">
                <div className="h-4 bg-slate-200 rounded w-32"></div>
                <div className="h-8 bg-slate-200 rounded w-24"></div>
              </div>
            </div>
            <div className="bg-slate-100 px-5 py-2.5 border-t border-slate-200">
              <div className="h-3 bg-slate-200 rounded w-20"></div>
            </div>
          </div>
        ))}
      </div>

      {/* Quick Actions Skeleton */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="bg-slate-100 px-6 py-3.5 border-b border-slate-200">
          <div className="h-4 bg-slate-200 rounded w-32"></div>
        </div>
        <div className="p-5">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {[...Array(4)].map((_, i) => (
              <div key={i} className="p-5 bg-slate-100 border border-slate-200 rounded-lg">
                <div className="h-8 w-8 bg-slate-200 rounded mx-auto mb-3"></div>
                <div className="h-4 bg-slate-200 rounded w-full mb-2"></div>
                <div className="h-3 bg-slate-200 rounded w-3/4 mx-auto"></div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Getting Started Skeleton */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="bg-slate-200 h-12"></div>
        <div className="p-6 space-y-4">
          <div className="flex gap-4">
            <div className="w-6 h-6 bg-slate-200 rounded flex-shrink-0"></div>
            <div className="flex-1 space-y-3">
              <div className="h-4 bg-slate-200 rounded"></div>
              <div className="h-4 bg-slate-200 rounded w-5/6"></div>
              <div className="h-10 bg-slate-200 rounded w-40 mt-4"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
