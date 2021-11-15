defmodule Tefla.Table.Deck do
  @moduledoc """
  Struct for representing the state of a deck of cards.
  """

  use TypedStruct

  alias Tefla.Table.Card

  @type t() :: list(Card.t())

  @suits [:clubs, :diamonds, :hearts, :spades]
  @aces_high_faces [
    :two,
    :three,
    :four,
    :five,
    :six,
    :seven,
    :eight,
    :nine,
    :ten,
    :jack,
    :queen,
    :king,
    :ace
  ]

  @standard_aces_high Enum.flat_map(@suits, fn s ->
                        for f <- @aces_high_faces do
                          %Card{suit: s, face: f}
                        end
                      end)

  def standard do
    @standard_aces_high
  end

  @doc """
  Randomize the cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Return the first card, on "top" of the deck.
  """
  def top_card([first | _rest]) do
    first
  end

  @doc """
  Deal the cards into `hands` number of hands. By default deals all cards in the deck, unless a `hand_size` option
  is sent in which case up to that many cards will be dealt per hand.

  Parameters:
    - deck, the deck to deal
    - hands, number of hands (defaults to 4)
    - opts
       - max_hand_size: maximum number of cards to deal to each hand, possibly leaving leftover cards
       - even_hands: ensure to always deal an equal number of cards to each hand, possibly leaving leftover cards,
                     default true
  """
  @type deal_result() :: {list(list(Card.t())), t()}
  @spec deal(t()) :: deal_result()
  @spec deal(t(), integer()) :: deal_result()
  @spec deal(t(), integer(), [keyword()]) :: deal_result()
  def deal(cards, num_hands \\ 4, opts \\ []) do
    max_hand_size = Keyword.get(opts, :max_hand_size, nil)
    even_hands = Keyword.get(opts, :even_hands, true)
    deck_size = length(cards)

    hand_size =
      if rem(deck_size, num_hands) > 0 and not even_hands do
        div(deck_size, num_hands) + 1
      else
        div(deck_size, num_hands)
      end

    hand_size = if is_nil(max_hand_size), do: hand_size, else: min(hand_size, max_hand_size)
    empty_hands = Enum.map(1..num_hands, fn _ -> [] end)

    Enum.with_index(cards)
    |> Enum.reduce({empty_hands, []}, fn {card, i}, {hands, leftover} ->
      cards_dealt = i
      cur_hand_i = if i >= num_hands, do: rem(i, num_hands), else: i
      cur_hand_size = div(cards_dealt, num_hands)

      if cur_hand_size < hand_size do
        hands = List.update_at(hands, cur_hand_i, fn cur_hand -> [card | cur_hand] end)
        {hands, leftover}
      else
        leftover = [card | leftover]
        {hands, leftover}
      end
    end)
  end
end
