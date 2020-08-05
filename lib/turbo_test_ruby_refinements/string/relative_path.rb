# frozen_string_literal: true

require "pathname"

module TurboTestRubyRefinements
  module StringRelativePath
    class << self
      def fetch(key)
        @path_cache ||= {}
        return @path_cache[key] if @path_cache.key?(key)

        @path_cache[key] = yield
      end

      def app_root_path
        @app_root_path ||= Pathname.new(Dir.pwd)
      end
    end

    refine ::String do
      def relative_path
        StringRelativePath.fetch(self) do
          path = Pathname.new(self)
          return self unless path.exist?

          unless path.relative?
            path = path.realpath.relative_path_from(StringRelativePath.app_root_path)
          end
          path.cleanpath.to_s
        end
      end
    end

    refine ::NilClass do
      def relative_path
        self
      end
    end
  end
end
