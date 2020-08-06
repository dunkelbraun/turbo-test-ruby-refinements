require_relative "lib/turbo_test_ruby_refinements/version"

Gem::Specification.new do |spec|
  spec.name          = "turbo_test_ruby_refinements"
  spec.version       = TurboTestRubyRefinements::VERSION
  spec.authors       = ["Marcos Essindi"]
  spec.email         = ["marcessindi@icloud.com"]

  spec.summary       = "Collection of refinements for Ruby classes"
  spec.homepage      = "https://github.com/dunkelbraun/turbo-test-ruby-refinements"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
   spec.metadata["source_code_uri"] = "https://github.com/dunkelbraun/turbo-test-ruby-refinements"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.14.1"
end
