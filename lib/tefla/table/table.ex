defmodule Tefla.Table do
  @moduledoc """
  Struct for representing the state of a entire game, including placement of all cards.

  Players at the table are identified by the index of their hand in the `hands` list. With indices increasing to
  the left of each player. This way if the dealer is 0, in most games player 1 leads the first trick. For a trick
  led by player 1, the players' play order in the trick is: `[1, 2, 3, 0]` (assuming standard play to the left).
  """

  use TypedStruct

  alias Tefla.Table.Deck
  alias Tefla.Table.Card
  alias Tefla.Table.Player
  alias Tefla.Table.Move

  @type deck :: list(Card.t())
  @type hand :: list(Card.t())

  typedstruct do
    @typedoc "Game table, includes the current state of player hands, the deck, current trick, etc."

    # the deck of playing cards, generally empty after the hands have been dealt
    field :deck, Deck.t(), enforce: true

    # the players' hands
    field :players, list(Player.t()), enforce: true

    # current trick being played
    field :trick, list(Card.t()), enforce: true

    # which player has the lead
    field :lead, integer(), enforce: true

    # which player is the dealer
    field :dealer, integer(), enforce: true

    # which player is the dealer
    field :valid_moves, list(Move.t()), enforce: true
  end
end
