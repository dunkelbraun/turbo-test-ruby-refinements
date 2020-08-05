# frozen_string_literal: true

module TurboTestRubyRefinements
  module ObjectLoadedConstants
    module Methods
      def loaded_constants
        constants.find_all { |constant| self.autoload?(constant).nil? }
      end
    end

    refine ::Object.singleton_class do
      include Methods
    end

    refine ::Module do
      include Methods
    end
  end
end
