module Appsignal
  class GarbageCollectionProfiler
    def total_time
      time = (GC::Profiler.total_time * 1000).round
      GC::Profiler.clear
      time
    end
  end
end
