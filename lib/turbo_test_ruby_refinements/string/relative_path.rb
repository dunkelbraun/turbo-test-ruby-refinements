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
          return self unless File.exist?(self)

          path = path_to_relative_path(Pathname.new(self))
          path.cleanpath.to_s
        end
      end

      def path_to_relative_path(path)
        return path if path.relative?

        path.realpath.relative_path_from(StringRelativePath.app_root_path)
      end
    end

    refine ::NilClass do
      def relative_path
        self
      end
    end
  end
end
