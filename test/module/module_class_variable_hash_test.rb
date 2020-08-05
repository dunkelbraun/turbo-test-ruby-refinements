# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::ClassVariableHash

describe "TurboTestRubyRefinements::ClassVariableHash" do
  before do
    define_class "TestClassA"
  end

  after do
    remove_class "TestClassA"
  end

  describe "#class_variable_hash" do
    it "returns a hash with the class variable names and object ids" do
      content_one = "232"
      content_two = "333"

      TestClassA.class_variable_set(:@@var_one, content_one)
      TestClassA.class_variable_set(:@@var_two, content_two)

      expected_hash = {
        "@@var_one".to_sym => content_one.object_id,
        "@@var_two".to_sym => content_two.object_id
      }
      assert_equal expected_hash, TestClassA.class_variable_hash
    end

    it "returns a hash with the class variable names and object ids that are available" do
      content = "333"
      TestClassA.class_variable_set(:@@var_one, "232")
      TestClassA.class_variable_set(:@@var_two, content)

      TestClassA.stubs(:class_variable_get).with(:@@var_one).raises(StandardError, "failure")
      TestClassA.stubs(:class_variable_get).with(:@@var_two).returns(content)
      expected_hash = {
        "@@var_two".to_sym => content.object_id
      }
      assert_equal expected_hash, TestClassA.class_variable_hash
    end
  end
end
