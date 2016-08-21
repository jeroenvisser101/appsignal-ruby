require 'spec_helper'

class FakeGCProfiler
  attr_writer :total_time

  def total_time
    @total_time ||= 0
  end

  def clear
    @total_time = 0
  end
end

describe Appsignal::GarbageCollectionProfiler do
  before do
    @internal_profiler = FakeGCProfiler.new
    allow_any_instance_of(Appsignal::GarbageCollectionProfiler)
      .to receive(:internal_profiler)
      .and_return(@internal_profiler)
  end

  it "should have a total time of 0" do
    expect(Appsignal::GarbageCollectionProfiler.new.total_time).to eq(0)
  end

  describe "after a GC run" do
    before do
      @internal_profiler.total_time = 0.12345
      @profiler = Appsignal::GarbageCollectionProfiler.new
    end

    it "should take the total time from Ruby's GC::Profiler" do
      expect(@profiler.total_time).to eq(123)
    end

    it "should clear Ruby's GC::Profiler" do
      expect(@internal_profiler).to receive(:clear)
      @profiler.total_time
    end
  end

  describe "after multiple GC runs" do
    it "should add all times from Ruby's GC::Profiler together" do
      profiler = Appsignal::GarbageCollectionProfiler.new

      2.times do
        @internal_profiler.total_time = 0.12345
        profiler.total_time
      end

      expect(profiler.total_time).to eq(246)
    end
  end
end
