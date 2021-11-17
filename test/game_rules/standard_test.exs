defmodule Tefla.GameRules.StandardTest do
  use ExUnit.Case, async: true

  alias Tefla.GameRules.Standard
  alias Tefla.Table.Deck.MockShuffler
  alias Tefla.Table.Card

  setup do
    Mox.stub(MockShuffler, :shuffle, &Function.identity/1)
    :ok
  end

  test "new -> deal" do
    table = Standard.new()
    assert length(table.deck) == 52
    assert length(table.players) == 4
    assert table.dealer == 0
    Mox.expect(MockShuffler, :shuffle, fn deck -> Enum.sort(deck, &Standard.compare_cards/2) end)
    {:ok, table} = Standard.deal(table)
    assert length(table.deck) == 0
    assert table.dealer == 0
    assert table.lead == 1
    assert length(table.players) == 4
    [player1, player2, player3, player4] = table.players
    assert length(player1.hand) == 13
    assert length(player2.hand) == 13
    assert length(player3.hand) == 13
    assert length(player4.hand) == 13

    assert hd(player4.hand) == Card.new(:ace, :spades)
    assert hd(player3.hand) == Card.new(:ace, :hearts)
    assert hd(player2.hand) == Card.new(:ace, :diamonds)
    assert hd(player1.hand) == Card.new(:ace, :clubs)

    Mox.verify!()
  end

  test "deal updates lead to left of dealer" do
    table = %{Standard.new() | dealer: 2}
    {:ok, table} = Standard.deal(table)
    assert table.lead == 3
  end

  test "deal updates lead to left of dealer, wraps around" do
    table = %{Standard.new() | dealer: 3}
    {:ok, table} = Standard.deal(table)
    assert table.lead == 0
  end
end
