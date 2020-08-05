# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::StringJSONParse

describe "TurboTestRubyRefinements::StringJSONParse" do
  it "parses a string as json" do
    string = "{\"a\":1,\"b\":2,\"c\":3}"
    expected_hash = { "a" => 1, "b" => 2, "c" => 3 }
    assert_equal expected_hash, string.parse_as_json
  end

  it "parses a string as json symbolizing names" do
    string = "{\"a\":1,\"b\":2,\"c\":3}"
    expected_hash = { a: 1, b: 2, c: 3 }
    assert_equal expected_hash, string.parse_as_json(symbolize_names: true)
  end

  it "returns nil when parsing an invalid string as json" do
    string = "2323, 22323"
    assert_nil string.parse_as_json(symbolize_names: true)
  end

  it "returns nil when parsing nil as json" do
    assert_nil nil.parse_as_json(symbolize_names: true)
  end
end
