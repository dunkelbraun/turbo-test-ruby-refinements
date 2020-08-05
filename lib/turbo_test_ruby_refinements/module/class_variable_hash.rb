# frozen_string_literal: true

module TurboTestRubyRefinements
  module ClassVariableHash
    refine ::Module do
      def class_variable_hash
        class_variables.each_with_object({}) do |class_variable, memo|
          begin
            memo[class_variable] = class_variable_get(class_variable).object_id
          rescue StandardError
            # Autoloaded classes may list class variables, but can raise an exception when
            # trying to access them if the class is is not fully loaded (ie. when tracing code)
          end
        end
      end
    end
  end
end
