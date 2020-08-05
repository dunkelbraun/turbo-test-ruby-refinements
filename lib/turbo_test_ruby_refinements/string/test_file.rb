# frozen_string_literal: true

module TurboTestRubyRefinements
  module StringTestFile
    TEST_MATCHER = /^(.+\.feature|.+_spec.rb|.+_test\.rb)$/.freeze

    refine ::String do
      def test_file?
        !match(TEST_MATCHER).nil?
      end
    end

    refine ::NilClass do
      def test_file?
        false
      end
    end
  end
end
