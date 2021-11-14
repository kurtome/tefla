defmodule Tefla.TableTest do
  use ExUnit.Case, async: true

  alias Tefla.Table

  test "new -> deal" do
    table = Table.new()
    assert length(table.deck) == 52
    assert length(table.hands) == 4
    {:ok, table} = Table.shuffle_deal(table)
    assert length(table.deck) == 0
    assert length(table.hands) == 4
    [hand1, hand2, hand3, hand4] = table.hands
    assert length(hand1) == 13
  end
end
