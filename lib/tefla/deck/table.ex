defmodule Tefla.Table do
  @moduledoc """
  Struct for representing the state of a entire game, including placement of all cards.

  Players at the table are identified by the index of their hand in the `hands` list. With indices increasing to
  the left of each player. This way if the dealer is 0, in most games player 1 leads the first trick. For a trick
  led by player 1, the players' play order in the trick is: `[1, 2, 3, 0]` (assuming standard play to the left).
  """

  use TypedStruct

  alias Tefla.Deck
  alias Tefla.Deck.Card
  alias Tefla.Deck.Hand

  @type deck :: list(Card.t())
  @type hand :: list(Card.t())

  typedstruct do
    @typedoc "Game table, includes the current state of player hands, the deck, current trick, etc."

    # the deck of playing cards, generally empty after the hands have been dealt
    field :deck, Deck.t(), enforce: true

    # the players' hands
    field :hands, list(Hand.t()), enforce: true

    # current trick being played
    field :trick, list(Card.t()), enforce: true

    # which player has the lead
    field :lead, integer(), enforce: true

    # which player is the dealer
    field :dealer, integer(), enforce: true
  end

  @spec new() :: t()
  def new() do
    %__MODULE__{
      deck: Deck.standard(),
      hands: Enum.map(1..4, fn _ -> Hand.empty() end),
      trick: [],
      lead: 1,
      dealer: 0
    }
  end

  @spec shuffle_deal(t()) :: {:ok, t()} | {:error, atom()}
  def shuffle_deal(%__MODULE__{dealer: dealer, deck: deck, hands: hands, trick: []})
      when length(deck) == 52 do
    players = length(hands)

    {dealt_hands, leftover} =
      Deck.shuffle(deck)
      |> Deck.deal(players)

    {:ok,
     %__MODULE__{
       deck: leftover,
       hands: dealt_hands,
       trick: [],
       lead: rem(dealer + 1, players),
       dealer: dealer
     }}
  end

  def shuffle_deal(%__MODULE__{}), do: {:error, :invalid_input}
end
