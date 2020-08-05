# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::ObjectLoadedConstants

describe "TurboTestRubyRefinements::ObjectLoadedConstants" do
  after do
    Object.send(:remove_const, "LoadedConstClassA") if defined?(LoadedConstClassA)
    Object.send(:remove_const, "LoadedConstClassB") if defined?(LoadedConstClassB)
    Object.send(:remove_const, "LoadedConstModuleA") if defined?(LoadedConstModuleA)
    Object.send(:remove_const, "LoadedConstModuleB") if defined?(LoadedConstModuleB)
  end

  describe "#loaded_constants" do
    describe "for a class" do
      before do
        define("class", "A")
        define_autoloaded_in_file("class", "B")
        define("class", "B")
        define_autoloaded_in_file("class", "B")
      end

      it "returns a list of loaded constants without the not loaded autoloaded constants" do
        expected_constants = %i[DomainError PI E ModuleA HELLO].sort
        assert_equal expected_constants, LoadedConstClassA.loaded_constants.sort
      end

      it "returns a list of loaded constants with the loaded autoloaded constants" do
        LoadedConstClassB::AutoloadModuleB

        expected_constants = %i[AutoloadModuleB DomainError PI E ModuleB HELLO].sort
        assert_equal expected_constants, LoadedConstClassB.loaded_constants.sort
      end

      it "returns a list of loaded constants including added constants" do
        LoadedConstClassA.const_set(:BYE, 1)

        expected_constants = %i[DomainError PI E ModuleA HELLO BYE].sort
        assert_equal expected_constants, LoadedConstClassA.loaded_constants.sort
      end

      it "returns a list of loaded constants without removed constants" do
        LoadedConstClassA.send(:remove_const, :ModuleA)

        expected_constants = %i[DomainError PI E HELLO].sort
        assert_equal expected_constants, LoadedConstClassA.loaded_constants.sort
      end
    end

    describe "for a module" do
      before do
        define("module", "A")
        define_autoloaded_in_file("module", "B")
        define("module", "B")
        define_autoloaded_in_file("module", "B")
      end

      it "returns a list of loaded constants without the not loaded autoloaded constants" do
        expected_constants = %i[DomainError PI E ModuleA HELLO].sort
        assert_equal expected_constants, LoadedConstModuleA.loaded_constants.sort
      end

      it "returns a list of loaded constants with the loaded autoloaded constants" do
        ::LoadedConstModuleB::AutoloadModuleB

        expected_constants = %i[AutoloadModuleB DomainError PI E ModuleB HELLO].sort
        assert_equal expected_constants, LoadedConstModuleB.loaded_constants.sort
      end

      it "returns a list of loaded constants including added constants" do
        LoadedConstModuleA.const_set(:BYE, 1)

        expected_constants = %i[DomainError PI E ModuleA HELLO BYE].sort
        assert_equal expected_constants, LoadedConstModuleA.loaded_constants.sort
      end

      it "returns a list of loaded constants without removed constants" do
        LoadedConstModuleA.send(:remove_const, :ModuleA)

        expected_constants = %i[DomainError PI E HELLO].sort
        assert_equal expected_constants, LoadedConstModuleA.loaded_constants.sort
      end
    end
  end

  private

  def define(type, name)
    Object.class_eval <<~RUBY, __FILE__, __LINE__ + 1
      #{type} ::LoadedConst#{type.capitalize}#{name}
        module Module#{name}
        end
        include Math
        autoload :AutoloadModule#{name}, Dir.pwd + "/tmp/#{type}_autoload_module_#{name.downcase}.rb"
        HELLO = 1
      end
    RUBY
  end

  def define_autoloaded_in_file(type, name)
    File.open("tmp/#{type}_autoload_module_#{name.downcase}.rb", "w+") do |file|
      file.write <<~RUBY
        #{type} ::LoadedConst#{type.capitalize}#{name}
          module AutoloadModule#{name}
          end
        end
      RUBY
    end
  end
end
