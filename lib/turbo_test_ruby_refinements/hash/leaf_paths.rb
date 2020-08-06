# frozen_string_literal: true

module TurboTestRubyRefinements
  module HashLeafPaths
    refine ::Hash.singleton_class do
      # Returns an array with a list of nested keys in the hash
      #
      # h = { key1: "1", key2: "2", key3: { key4: { key41: "3", key42: "4" }
      # h.leaf_paths => [ "key1", "key2", "key3.key4.key41", "key3.key4.key42" ]
      def leaf_paths(hash = {}, memo = [], scope = [])
        case hash
        when Hash
          traverse_hash(hash, memo, scope)
          memo
        else
          memo.push scope.join(".")
          scope.pop
        end
      end

      def traverse_hash(hash, memo, scope)
        hash.each_key do |key|
          leaf_paths(hash[key], memo, scope.push(key))
          scope.pop if scope.last == key
        end
      end
    end
  end
end
