module Appsignal
  class GarbageCollectionProfiler
    def initialize
      @total_time = 0
    end

    def total_time
      @total_time += (internal_profiler.total_time * 1000).round
      internal_profiler.clear
      @total_time
    end

    private

    def internal_profiler
      GC::Profiler
    end
  end
end
