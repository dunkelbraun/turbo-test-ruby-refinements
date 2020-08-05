# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

if RUBY_VERSION >= "2.7"
  require "simplecov"
  SimpleCov.start do
    enable_coverage :branch
    minimum_coverage line: 100, branch: 100
  end
end

require "turbo_test_ruby_refinements"
require "minitest/autorun"
require "byebug"

class Minitest::Spec
  before do
    FileUtils.mkdir_p "tmp"
  end

  after do
    FileUtils.rm_rf "tmp"
  end
end

module Minitest::Spec::DSL
  alias test it
end

require_relative "test_helpers/define_class"
