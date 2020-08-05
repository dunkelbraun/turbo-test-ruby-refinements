# frozen_string_literal: true

module TurboTestRubyRefinements
  module InstanceVariableHash
    refine ::Module do
      def instance_variable_hash
        instance_variables.each_with_object({}) do |instance_variable, memo|
          begin
            memo[instance_variable] = instance_variable_get(instance_variable).object_id
          rescue StandardError
            # Autoloaded classes may list instance variables, but can raise an exception when
            # trying to access them if the class is is not fully loaded (ie. when tracing code)
          end
        end
      end
    end
  end
end
