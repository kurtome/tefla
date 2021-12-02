defmodule Tefla.GameRules.StandardTest do
  use Tefla.DataCase, async: true

  alias Tefla.GameRules.Standard
  alias Tefla.Table
  alias Tefla.Table.Deck.MockShuffler
  alias Tefla.Table.Card
  alias Tefla.Table.Move

  setup do
    Mox.stub(MockShuffler, :shuffle, &Function.identity/1)
    :ok
  end

  test "compare cards, two - ace" do
    result = Standard.compare_cards(Card.new(:two, :hearts), Card.new(:ace, :hearts))
    assert result == true
    result = Standard.compare_cards(Card.new(:ace, :hearts), Card.new(:two, :hearts))
    assert result == false
  end

  test "new -> deal" do
    table = Standard.new()
    assert length(table.deck) == 52
    assert length(table.players) == 4
    assert table.dealer == 0

    #    Mox.expect(MockShuffler, :shuffle, fn deck -> Enum.sort(deck, &Standard.compare_cards/2) end)
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

    assert hd(player4.hand) == Card.new(:five, :clubs)
    assert hd(player3.hand) == Card.new(:four, :clubs)
    assert hd(player2.hand) == Card.new(:three, :clubs)
    assert hd(player1.hand) == Card.new(:two, :clubs)

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

  test "play move" do
    table = build(:table_identity_deal)

    [player1, player2, player3, player4] = table.players
    assert hd(player4.hand) == Card.new(:five, :clubs)
    assert hd(player3.hand) == Card.new(:four, :clubs)
    assert hd(player2.hand) == Card.new(:three, :clubs)
    assert hd(player1.hand) == Card.new(:two, :clubs)

    {:ok, table} = Standard.play(table, Move.new(1, 0))
    assert table.trick == [Card.new(:three, :clubs)]
    [player1, player2, player3, player4] = table.players
    assert length(player1.hand) == 13
    assert length(player2.hand) == 12
    assert length(player3.hand) == 13
    assert length(player4.hand) == 13

    {:ok, table} = Standard.play(table, Move.new(2, 0))
    assert table.trick == [Card.new(:three, :clubs), Card.new(:four, :clubs)]
    [player1, player2, player3, player4] = table.players
    assert length(player1.hand) == 13
    assert length(player2.hand) == 12
    assert length(player3.hand) == 12
    assert length(player4.hand) == 13

    {:ok, table} = Standard.play(table, Move.new(3, 0))

    assert table.trick == [
             Card.new(:three, :clubs),
             Card.new(:four, :clubs),
             Card.new(:five, :clubs)
           ]

    [player1, player2, player3, player4] = table.players
    assert length(player1.hand) == 13
    assert length(player2.hand) == 12
    assert length(player3.hand) == 12
    assert length(player4.hand) == 12

    {:ok, table} = Standard.play(table, Move.new(0, 0))

    assert table.trick == [
             Card.new(:three, :clubs),
             Card.new(:four, :clubs),
             Card.new(:five, :clubs),
             Card.new(:two, :clubs)
           ]

    [player1, player2, player3, player4] = table.players
    assert length(player1.hand) == 12
    assert length(player2.hand) == 12
    assert length(player3.hand) == 12
    assert length(player4.hand) == 12
  end

  test "play full game" do
    table = build(:table_deal)

    table =
      Enum.reduce(1..52, table, fn i, table ->
        {:ok, valid_moves} = Standard.valid_moves(table)
        assert length(valid_moves) > 0
        move = Enum.random(valid_moves)
        {:ok, table} = Standard.play(table, move)

        assert Table.hand_cards_remaining(table) == 52 - i

        if Table.trick_full?(table) do
          {:ok, table} = Standard.collect_trick(table)
          table
        else
          table
        end
      end)

    assert Table.hand_in_progress?(table) == false
  end
end
