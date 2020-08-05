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
      # rubocop:disable Lint/UnusedMethodArgument
      def parse_as_json(symbolize_names:)
        nil
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end
