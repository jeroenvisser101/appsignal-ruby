module Appsignal
  class GarbageCollectionProfiler
    def initialize
      @total_time = 0
    end

    def total_time
      lock.synchronize do
        @total_time += (internal_profiler.total_time * 1000).round
        internal_profiler.clear
      end
      @total_time
    end

    private

    def self.lock
      @lock ||= Mutex.new
    end

    def internal_profiler
      GC::Profiler
    end

    def lock
      self.class.lock
    end
  end
end
