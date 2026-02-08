export default function InventoryLoading() {
  return (
    <div className="space-y-6 animate-pulse">
      {/* Banner Skeleton */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="bg-slate-200 h-32"></div>
      </div>

      {/* Filter Bar Skeleton */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="p-5">
          <div className="flex flex-col sm:flex-row gap-4">
            <div className="flex-1 h-10 bg-slate-200 rounded"></div>
            <div className="flex gap-2">
              <div className="w-20 h-10 bg-slate-200 rounded"></div>
              <div className="w-20 h-10 bg-slate-200 rounded"></div>
            </div>
          </div>
        </div>
      </div>

      {/* Table Skeleton */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        {/* Table Header */}
        <div className="bg-slate-100 px-6 py-3 border-b border-slate-200">
          <div className="flex gap-4">
            <div className="h-4 bg-slate-200 rounded w-32"></div>
            <div className="h-4 bg-slate-200 rounded w-24"></div>
            <div className="h-4 bg-slate-200 rounded w-20"></div>
            <div className="h-4 bg-slate-200 rounded w-24"></div>
          </div>
        </div>

        {/* Table Rows */}
        {[...Array(6)].map((_, i) => (
          <div key={i} className="px-6 py-4 border-b border-slate-200">
            <div className="flex gap-4">
              <div className="h-4 bg-slate-200 rounded w-32"></div>
              <div className="h-4 bg-slate-200 rounded w-24"></div>
              <div className="h-4 bg-slate-200 rounded w-20"></div>
              <div className="h-4 bg-slate-200 rounded w-24"></div>
            </div>
          </div>
        ))}
      </div>

      {/* Pagination Skeleton */}
      <div className="flex items-center justify-between">
        <div className="h-4 bg-slate-200 rounded w-32"></div>
        <div className="flex gap-2">
          <div className="w-10 h-10 bg-slate-200 rounded"></div>
          <div className="w-10 h-10 bg-slate-200 rounded"></div>
        </div>
      </div>
    </div>
  )
}
