# frozen_string_literal: true

module TurboTestRubyRefinements
  module HashLeafPaths
    refine ::Hash.singleton_class do
      # Returns an array with a list of nested keys in the hash
      #
      # h = { key1: "1", key2: "2", key3: { key4: { key41: "3", key42: "4" }
      # h.leaf_paths => [ "key1", "key2", "key3.key4.key41", "key3.key4.key42" ]
      def leaf_paths(hash = {}, memo = [], scope = [])
        unless hash.is_a?(Hash)
          memo << scope.join(".")
          scope.pop
          return
        end
        hash.each_key do |key|
          leaf_paths(hash[key], memo, scope << key)
          scope.pop if scope.last == key
        end
        memo
      end
    end
  end
end
