class FakeGCProfiler
  attr_writer :total_time
  attr_writer :clear_delay

  def total_time
    @total_time ||= 0
  end

  def clear
    sleep clear_delay
    @total_time = 0
  end

  private

  def clear_delay
    @clear_delay ||= 0
  end
end
