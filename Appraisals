# frozen_string_literal: true

case RUBY_VERSION
when ->(n) { n > "2.7" }
  appraise "ruby-2.7.x" do
    ruby "2.7.1"
    gem "simplecov"
    gem "byebug"
    gem "rubocop"
  end
when ->(n) { n > "2.6" }
  appraise "ruby-2.6.6" do
    ruby "2.6.6"
    gem "byebug"
  end
when ->(n) { n > "2.5" }
  appraise "ruby-2.5.8" do
    ruby "2.5.8"
    gem "byebug"
  end
when ->(n) { n > "2.4" }
  appraise "ruby-2.4.10" do
    ruby "2.4.10"
    gem "byebug"
  end
when ->(n) { n > "2.3" }
  appraise "ruby-2.3.8" do
    ruby "2.3.8"
    gem "byebug", "~> 11.0.1"
  end
end
