module Appsignal
  class GarbageCollectionProfiler
    def initialize
      @total_time = 0
    end

    def total_time
      @total_time += (GC::Profiler.total_time * 1000).round
      GC::Profiler.clear
      @total_time
    end
  end
end
