# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::HashDeepMerge

describe "TurboTestRubyRefinements::HashDeepMerge" do
  test "deep merge" do
    hash_one = { a: "a", b: "b", c: { c1: "c1", c2: "c2", c3: { d1: "d1" } } }
    hash_two = { a: 1, c: { c1: 2, c3: { d2: "d2" } } }
    expected = {
      a: 1,
      b: "b",
      c: { c1: 2, c2: "c2", c3: { d1: "d1", d2: "d2" } }
    }
    assert_equal expected, hash_one.deep_merge(hash_two)

    hash_one.deep_merge!(hash_two)
    assert_equal expected, hash_one
  end

  test "deep merge with block" do
    hash_one = { a: "a", b: "b", c: { c1: "c1", c2: "c2", c3: { d1: "d1" } } }
    hash_two = { a: 1, c: { c1: 2, c3: { d2: "d2" } } }
    expected = {
      a: [:a, "a", 1],
      b: "b",
      c: { c1: [:c1, "c1", 2], c2: "c2", c3: { d1: "d1", d2: "d2" } }
    }
    assert_equal(expected, hash_one.deep_merge(hash_two) { |k, o, n| [k, o, n] })

    hash_one.deep_merge!(hash_two) { |k, o, n| [k, o, n] }
    assert_equal expected, hash_one
  end

  test "deep merge with falsey values" do
    hash_one = { e: false }
    hash_two = { e: "e" }
    expected = { e: [:e, false, "e"] }
    assert_equal(expected, hash_one.deep_merge(hash_two) { |k, o, n| [k, o, n] })

    hash_one.deep_merge!(hash_two) { |k, o, n| [k, o, n] }
    assert_equal expected, hash_one
  end
end

# Adapted from https://github.com/rails/rails/blob/v6.0.3.2/activesupport/test/core_ext/hash_ext_test.rb
