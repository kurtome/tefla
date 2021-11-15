defmodule Tefla.TableTest do
  use ExUnit.Case, async: true

  alias Tefla.Table

  test "new -> deal" do
    table = Table.new()
    assert length(table.deck) == 52
    assert length(table.players) == 4
    assert table.dealer == 0
    {:ok, table} = Table.shuffle_deal(table)
    assert length(table.deck) == 0
    assert table.dealer == 0
    assert table.lead == 1
    assert length(table.players) == 4
    [player1, player2, player3, player4] = table.players
    assert length(player1.hand) == 13
    assert length(player2.hand) == 13
    assert length(player3.hand) == 13
    assert length(player4.hand) == 13
  end

  test "deal updates lead to left of dealer" do
    table = %{Table.new() | dealer: 2}
    {:ok, table} = Table.shuffle_deal(table)
    assert table.lead == 3
  end

  test "deal updates lead to left of dealer, wraps around" do
    table = %{Table.new() | dealer: 3}
    {:ok, table} = Table.shuffle_deal(table)
    assert table.lead == 0
  end
end
