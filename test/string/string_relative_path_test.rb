# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::StringRelativePath

describe "TurboTestRubyRefinements::StringRelativePath" do
  before do
    TurboTestRubyRefinements::StringRelativePath.instance_variable_set(:@path_cache, nil)
  end

  describe "for files that exist" do
    before do
      FileUtils.mkdir_p("tmp/dir")
      FileUtils.touch("tmp/dir/file.rb")
    end

    it "returns the relative path from the current directory on absolute paths" do
      path = absolute_path("/tmp/dir/file.rb")
      assert_equal "tmp/dir/file.rb", path.relative_path
    end

    it "returns the relative path from the current directory on relative paths" do
      paths = ["tmp/dir/file.rb", "./tmp/dir/file.rb"]
      assert_equal ["tmp/dir/file.rb"], [paths.first.relative_path, paths.last.relative_path].uniq
    end
  end
  describe "for files that do not exist" do
    it "returns the string on absolute paths" do
      path = absolute_path("/tmp/project/path/dir/file.rb")
      assert_equal path, path.relative_path
    end

    it "returns the string on relative paths" do
      paths = ["./tmp/project/file.rb", "./tmp/another_project/file2.rb"]
      assert_equal paths, [paths.first.relative_path, paths.last.relative_path]
    end
  end

  describe "on NilClass" do
    it "returns nil" do
      assert_nil nil.relative_path
    end
  end

  describe "caching" do
    let(:path_one) { absolute_path("tmp/file.rb") }
    let(:path_two) { absolute_path("tmp/file2.rb") }

    before do
      FileUtils.touch path_one
      FileUtils.touch path_two
      TurboTestRubyRefinements::StringRelativePath.instance_variable_set(:@path_cache, {})
    end

    it "stores resolved paths in a cache" do
      path_one.relative_path
      assert_equal "tmp/file.rb", path_cache[path_one]
    end

    it "fetches resolved paths from the cache" do
      path_cache[path_one] = nil
      path_cache[path_two] = "tmp/file3.rb"
      assert_equal [nil, "tmp/file3.rb"], [path_one.relative_path, path_two.relative_path]
    end
  end

  private

  def absolute_path(relative_path)
    File.join(Dir.pwd, relative_path)
  end

  def path_cache
    TurboTestRubyRefinements::StringRelativePath.instance_variable_get(:@path_cache)
  end
end
