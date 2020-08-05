# frozen_string_literal: true

require "fiddle"

module TurboTestRubyRefinements
  module ModuleName
    ANONYMOUS_CLASS_MATCHER = /(#<Class:(0x\w+)>)/.freeze

    refine ::Module do
      # Resolves singleton class names to the name of the class
      #
      # class AClass;end
      # AClass.singleton_class.name
      # => "#<Class:AClass>"
      # AClass.turbo_test_name
      # => "AClass"
      #
      # anonymous = class << AClass; class SomeClass; self; end; end
      # anonymous.name
      # => "#<Class:0x00007fd72a1bce30>::SomeClass"
      # anonymous.turbo_test_original_class
      # => "AClass::SomeClass"
      def turbo_test_name
        return translated_name unless singleton_class?

        obj = ObjectSpace.each_object(self).first
        case obj
        when Module
          obj.turbo_test_name
        else
          obj.class.turbo_test_name
        end
      end

      # Returns either self for a class or the class from which a class is the singleton class
      #
      # class AClass;end
      # AClass.singleton_class.name
      # => Class
      # AClass.singleton_class.turbo_test_original_class
      # => AClass
      def turbo_test_original_class
        return self unless singleton_class?

        obj = ObjectSpace.each_object(self).first
        case obj
        when Module
          obj.turbo_test_original_class
        else
          obj.class.turbo_test_original_class
        end
      end

      def translated_name
        return if name.nil?

        name.gsub(TurboTestRubyRefinements::ModuleName::ANONYMOUS_CLASS_MATCHER) do |_match|
          obj = Fiddle::Pointer.new(Integer(Regexp.last_match(2))).to_value
          obj.turbo_test_name
        end
      end
      private :translated_name
    end
  end
end
