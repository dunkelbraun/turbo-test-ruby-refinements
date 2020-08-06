![Tests](https://github.com/dunkelbraun/turbo-test-ruby-refinements/workflows/Tests/badge.svg?branch=main)
[![Maintainability](https://api.codeclimate.com/v1/badges/d84d7949fbabe8712161/maintainability)](https://codeclimate.com/github/dunkelbraun/turbo-test-ruby-refinements/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/dunkelbraun/turbo-test-ruby-refinements/badge.svg?branch=main)](https://coveralls.io/github/dunkelbraun/turbo-test-ruby-refinements?branch=main)

# TurboTestRubyRefinements

Collection of refinements for Ruby classes:

- TurboTestRubyRefinements::HashDeepMerge (Hash)

    ```#deep_merge``` from ActiveSupport
    ```#deep_merge!``` from ActiveSupport
- TurboTestRubyRefinements::HashLeafPaths (Hash)

    ```#leaf_paths```: returns an array with a list of nested keys in the hash
  
- TurboTestRubyRefinements::ModuleName (Module)

    ```#turbo_test_name```: resolves singleton and anonymous class names.

- TurboTestRubyRefinements::InstanceVariableHash (Module)

    ```#instance_variable_hash```
- TurboTestRubyRefinements::ClassVariableHash (Module)

    ```#class_variable_hash```

- TurboTestRubyRefinements::ObjectLoadedConstants (Object)

    ```#loaded_constants```

- TurboTestRubyRefinements::StringJSONParse (String)

    ```#parse_as_json```

- TurboTestRubyRefinements::StringRelativePath (String)

    ```#relative_path```

- TurboTestRubyRefinements::StringTestFile (String)

    ```#test_file?```

- TurboTestRubyRefinements::GemLoadedSpecsPaths (Gem)

    ```#loaded_specs_paths```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'turbo_test_ruby_refinements'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install turbo_test_ruby_refinements

## Usage

Activate the refinements you want to use at the top-level, and inside classes and modules.

```ruby
using TurboTestRubyRefinements::StringRelativePath
```


[Refinements Documentation](https://ruby-doc.org/core-2.7.1/doc/syntax/refinements_rdoc.html)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dunkelbraun/turbo_test_ruby_refinements. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dunkelbraun/turbo_test_ruby_refinements/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TurboTestRubyRefinements project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dunkelbraun/turbo_test_ruby_refinements/blob/master/CODE_OF_CONDUCT.md).
