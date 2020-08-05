# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::StringTestFile

describe "TurboTestRubyRefinements::StringTestFile" do
  test "a file ending in test.rb is a test file" do
    assert "a/path/class_a_test.rb".test_file?
    assert "class_a_test.rb".test_file?
  end

  test "a file ending in spec.rb is a test file" do
    assert "a/path/class_a_spec.rb".test_file?
    assert "class_a_spec.rb".test_file?
  end

  test "a file ending in .feature is a test file" do
    assert "a/path/class_a.feature".test_file?
    assert "class_a.feature".test_file?
  end

  test "a normal string is not test file" do
    refute "a/path/a_class.rb".test_file?
    refute "a_class.rb".test_file?
    refute "something".test_file?
  end

  test "nil is not test file" do
    refute nil.test_file?
  end
end
