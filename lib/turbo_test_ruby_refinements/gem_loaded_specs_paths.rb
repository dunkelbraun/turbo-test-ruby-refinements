# frozen_string_literal: true

module TurboTestRubyRefinements
  module GemLoadedSpecsPaths
    class << self
      attr_accessor :path_cache
    end

    refine ::Gem.singleton_class do
      def loaded_specs_paths
        GemLoadedSpecsPaths.path_cache ||= loaded_specs.each_with_object([]) do |spec, memo|
          memo << spec[1].full_gem_path
        end.sort!
      end
    end
  end
end
