defmodule Tefla.Table.DeskTest do
  use ExUnit.Case, async: true

  alias Tefla.Table.Deck

  test "deal 4 hands, full deck" do
    deck = Deck.standard()
    {[hand1, hand2, hand3, hand4], leftover} = Deck.deal(deck, 4)
    assert length(hand1) == 13
    assert length(hand2) == 13
    assert length(hand3) == 13
    assert length(hand4) == 13
    assert length(leftover) == 0
  end

  test "deal 5 hands, full deck, allow uneven hands" do
    deck = Deck.standard()
    {hands, leftover} = Deck.deal(deck, 5, even_hands: false)
    assert length(hands) == 5
    [hand1, hand2, hand3, hand4, hand5] = hands
    assert length(hand1) == 11
    assert length(hand2) == 11
    assert length(hand3) == 10
    assert length(hand4) == 10
    assert length(hand5) == 10
    assert length(leftover) == 0
  end

  test "deal 5 hands, full deck" do
    deck = Deck.standard()
    {hands, leftover} = Deck.deal(deck, 5)
    assert length(hands) == 5
    [hand1, hand2, hand3, hand4, hand5] = hands
    assert length(hand1) == 10
    assert length(hand2) == 10
    assert length(hand3) == 10
    assert length(hand4) == 10
    assert length(hand5) == 10
    assert length(leftover) == 2
  end

  test "deal 5 hands, hand size 8" do
    deck = Deck.standard()
    {hands, leftover} = Deck.deal(deck, 5, max_hand_size: 8)
    assert length(hands) == 5
    [hand1, hand2, hand3, hand4, hand5] = hands
    assert length(hand1) == 8
    assert length(hand2) == 8
    assert length(hand3) == 8
    assert length(hand4) == 8
    assert length(hand5) == 8
    assert length(leftover) == 12
  end
end
