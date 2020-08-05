# frozen_string_literal: true

module TurboTestRubyRefinements
  module HashDeepMerge
    refine ::Hash do
      # Returns a new hash with +self+ and +other_hash+ merged recursively.
      #
      #   h1 = { a: true, b: { c: [1, 2, 3] } }
      #   h2 = { a: false, b: { x: [3, 4, 5] } }
      #
      #   h1.deep_merge(h2) # => { a: false, b: { c: [1, 2, 3], x: [3, 4, 5] } }
      #
      # Like with Hash#merge in the standard library, a block can be provided
      # to merge values:
      #
      #   h1 = { a: 100, b: 200, c: { c1: 100 } }
      #   h2 = { b: 250, c: { c1: 200 } }
      #   h1.deep_merge(h2) { |key, this_val, other_val| this_val + other_val }
      #   # => { a: 100, b: 450, c: { c1: 300 } }
      def deep_merge(other_hash, &block)
        dup.deep_merge!(other_hash, &block)
      end

      # Same as +deep_merge+, but modifies +self+.
      def deep_merge!(other_hash, &block)
        merge!(other_hash) do |key, this_val, other_val|
          # We can't use use this.val.is_a?(Hash) because inside the refinement
          # returns false:
          #   - refined_hash.class != Hash
          if this_val.class.name == "Hash" && other_val.class.name == "Hash"
            this_val.deep_merge(other_val, &block)
          elsif block_given?
            block.call(key, this_val, other_val)
          else
            other_val
          end
        end
      end
    end
  end
end

# From: https://github.com/rails/rails/blob/v6.0.3.2/activesupport/lib/active_support/core_ext/hash/deep_merge.rb
