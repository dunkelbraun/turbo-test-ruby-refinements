# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::ModuleName

describe "TurboTestRubyRefinements::ModuleName" do
  before do
    define_class("TestClassA")
  end

  after do
    remove_class("TestClassA")
  end

  describe "#turbo_test_name" do
    it "returns the class name of a class" do
      assert_equal "TestClassA", TestClassA.turbo_test_name
    end

    it "returns the object class name for the singleton class of an object" do
      obj = TestClassA.new
      assert_equal "TestClassA", singleton_class(obj).turbo_test_name
      assert_equal "TestClassA", obj.singleton_class.turbo_test_name
    end

    it "returns the class name of the singleton class in a singleton class of a class" do
      assert_equal "TestClassA", singleton_class(TestClassA).turbo_test_name
      assert_equal "TestClassA", TestClassA.singleton_class.turbo_test_name
    end

    it "returns the class name of the metaclass in a metaclass of a class" do
      assert_equal "TestClassA", metaclass(TestClassA).turbo_test_name
      assert_equal "TestClassA", TestClassA.singleton_class.singleton_class.turbo_test_name
    end

    it "returns the name of a class created in an anonymous class" do
      anonymous_class = class << TestClassA
                          class SomeClass
                            self
                          end
      end
      assert_equal "TestClassA::SomeClass", anonymous_class.turbo_test_name

      anonymous_class = class << TestClassA
                          class SomeClass
                            class << self
                              class AnotherClass
                                self
                              end
                            end
                          end
      end
      assert_equal "TestClassA::SomeClass::AnotherClass", anonymous_class.turbo_test_name
    end

    it "returns nil when the class has no name" do
      TestClassA.singleton_class.define_method(:name) { nil }
      assert_nil TestClassA.turbo_test_name
    end
  end

  describe "#turbo_test_original_class" do
    it "returns the class in a class" do
      assert_equal TestClassA, TestClassA.turbo_test_original_class
    end

    it "returns the object class on a singleton class of an object" do
      obj = TestClassA.new
      assert_equal TestClassA, singleton_class(obj).turbo_test_original_class
      assert_equal TestClassA, obj.singleton_class.turbo_test_original_class
    end

    it "returns the class of the singleton class on a class' singleton class" do
      assert_equal TestClassA, singleton_class(TestClassA).turbo_test_original_class
      assert_equal TestClassA, TestClassA.singleton_class.turbo_test_original_class
    end

    it "returns the class name of the metaclass on a metaclass" do
      assert_equal TestClassA, metaclass(TestClassA).turbo_test_original_class
      assert_equal TestClassA, TestClassA.singleton_class.singleton_class.turbo_test_original_class
    end
  end
end
