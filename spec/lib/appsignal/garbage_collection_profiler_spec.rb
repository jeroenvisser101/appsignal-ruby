require 'spec_helper'

describe Appsignal::GarbageCollectionProfiler do
  before do
    GC::Profiler.stub(:total_time) { 0.0 }
  end

  it "should have a total time of 0" do
    expect(Appsignal::GarbageCollectionProfiler.new.total_time).to eq(0)
  end

  describe "after a GC run" do
    before do
      GC::Profiler.stub(:total_time) { 0.12345 }
      @profiler = Appsignal::GarbageCollectionProfiler.new
    end

    it "should take the total time from Ruby's GC::Profiler" do
      expect(@profiler.total_time).to eq(123)
    end

    it "should clear Ruby's GC::Profiler" do
      expect(GC::Profiler).to receive(:clear)
      @profiler.total_time
    end
  end
end
