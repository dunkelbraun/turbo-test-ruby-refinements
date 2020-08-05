# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::GemLoadedSpecsPaths

describe "TurboTestRubyRefinements::GemLoadedSpecsPaths" do
  before do
    TurboTestRubyRefinements::GemLoadedSpecsPaths.path_cache = nil
  end

  after do
    TurboTestRubyRefinements::GemLoadedSpecsPaths.path_cache = nil
  end

  describe "#loaded_specs_paths" do
    it "returns a list of loaded specs paths" do
      loaded_specs = {
        "gem_one" => mock.tap { |spec| spec.stubs(:full_gem_path).returns("/path/to/gem_one") },
        "gem_two" => mock.tap { |spec| spec.stubs(:full_gem_path).returns("/path/to/gem_two") }
      }
      Gem.stubs(:loaded_specs).returns(loaded_specs)

      assert_equal ["/path/to/gem_one", "/path/to/gem_two"], Gem.loaded_specs_paths
    end

    it "uses a cache to fetch the loaded spec paths" do
      cached_values = ["/path/to/abc", "/path/to/cdf"]
      TurboTestRubyRefinements::GemLoadedSpecsPaths.path_cache = cached_values
      assert_equal ["/path/to/abc", "/path/to/cdf"], Gem.loaded_specs_paths
    end
  end
end
