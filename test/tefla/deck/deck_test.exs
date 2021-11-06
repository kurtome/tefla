defmodule Tefla.DeskTest do
  use ExUnit.Case, async: true

  alias Tefla.Deck

  test "deal 4 hands, full deck" do
    deck = Deck.standard()
    [hand1, hand2, hand3, hand4] = Deck.deal(deck, 4)
    assert length(hand1.cards) == 13
    assert length(hand2.cards) == 13
    assert length(hand3.cards) == 13
    assert length(hand4.cards) == 13
  end

  test "deal 5 hands, full deck, allow uneven hands" do
    deck = Deck.standard()
    hands = Deck.deal(deck, 5, even_hands: false)
    assert length(hands) == 5
    [hand1, hand2, hand3, hand4, hand5] = hands
    assert length(hand1.cards) == 11
    assert length(hand2.cards) == 11
    assert length(hand3.cards) == 10
    assert length(hand4.cards) == 10
    assert length(hand5.cards) == 10
  end

  test "deal 5 hands, full deck" do
    deck = Deck.standard()
    hands = Deck.deal(deck, 5)
    assert length(hands) == 5
    [hand1, hand2, hand3, hand4, hand5] = hands
    assert length(hand1.cards) == 10
    assert length(hand2.cards) == 10
    assert length(hand3.cards) == 10
    assert length(hand4.cards) == 10
    assert length(hand5.cards) == 10
  end

  test "deal 5 hands, hand size 8" do
    deck = Deck.standard()
    hands = Deck.deal(deck, 5, max_hand_size: 8)
    assert length(hands) == 5
    [hand1, hand2, hand3, hand4, hand5] = hands
    assert length(hand1.cards) == 8
    assert length(hand2.cards) == 8
    assert length(hand3.cards) == 8
    assert length(hand4.cards) == 8
    assert length(hand5.cards) == 8
  end
end
