# frozen_string_literal: true

require "test_helper"

using TurboTestRubyRefinements::HashLeafPaths

describe "TurboTestRubyRefinements::HashLeafPaths" do
  test "leaf paths" do
    test_hash = {
      key1: "value1",
      key2: "value2",
      key3: {
        key4: {
          key41: "value4",
          key42: "value5"
        },
        key5: "value5",
        key5b: {
          key5b1: {
            key5b1c1: "value5",
            key5b1c2: "value5",
            key5b1c3: "value5",
            key5b1c4: "value5"
          },
          key5b2: "value5"
        }
      },
      key6: {
        key7: "value7",
        key8: {
          key9: "value9"
        }
      }
    }

    expected_leafs = [
      "key1",
      "key2",
      "key3.key4.key41",
      "key3.key4.key42",
      "key3.key5",
      "key3.key5b.key5b1.key5b1c1",
      "key3.key5b.key5b1.key5b1c2",
      "key3.key5b.key5b1.key5b1c3",
      "key3.key5b.key5b1.key5b1c4",
      "key3.key5b.key5b2",
      "key6.key7",
      "key6.key8.key9"
    ]

    assert_equal expected_leafs, ::Hash.leaf_paths(test_hash)
  end
end
