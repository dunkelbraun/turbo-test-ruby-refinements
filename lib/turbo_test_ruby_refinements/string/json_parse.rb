# frozen_string_literal: true

require "json"

module TurboTestRubyRefinements
  module StringJSONParse
    refine ::String do
      def parse_as_json(symbolize_names: false)
        JSON.parse self, symbolize_names: symbolize_names
      rescue JSON::ParserError
        nil
      end
    end
    refine ::NilClass do
      def parse_as_json(*)
        nil
      end
    end
  end
end
