# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::InstanceVariableHash

describe "" do
  before do
    define_class "TestClassA"
  end

  after do
    remove_class "TestClassA"
  end

  describe "#instance_variable_hash" do
    it "returns a hash with the instance variable names and object ids" do
      content_one = "232"
      content_two = "333"
      TestClassA.class_eval do
        @var_one = content_one
        @var_two = content_two
      end

      expected_hash = {
        "@var_one".to_sym => content_one.object_id,
        "@var_two".to_sym => content_two.object_id
      }
      assert_equal expected_hash, TestClassA.instance_variable_hash
    end

    it "returns a hash with the instance variable names and object ids that are available" do
      content = "333"
      TestClassA.class_eval do
        @var_one = "232"
        @var_two = content
      end

      TestClassA.stubs(:instance_variable_get).with(:@var_one).raises(StandardError, "failure")
      TestClassA.stubs(:instance_variable_get).with(:@var_two).returns(content)
      TestClassA.stubs(:instance_variable_get).with(:@mocha).returns(TestClassA)

      expected_hash = {
        "@var_two".to_sym => content.object_id,
        "@mocha".to_sym => TestClassA.object_id
      }
      assert_equal expected_hash, TestClassA.instance_variable_hash
    end
  end
end
