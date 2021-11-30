defprotocol Tefla.GameRules do
  @moduledoc """
  Defines valid state transitions for a `Tefla.Table`. Implementations of this protocol represent a game conventional
  card game, like: bridge, whist, spades, hearts, etc.
  """

  alias Tefla.Table
  alias Tefla.Table.Card
  alias Tefla.Table.Move

  @typep modifier_result :: {:ok, Table.t()} | {:error, String.t()}

  @doc """
  Creates a new game table with the deck and players necessary for this game.
  """
  @callback new() :: Table.t()

  @doc """
  Compares two cards from the deck, returns true if `first` is lower than (or equal to) `second`.

  This compares the cards' intrinsic ordering, which for trick taking may be different based on the game rules such as
  trump cards.
  """
  @callback compare_cards(Card.t(), Card.t()) :: boolean()

  @doc """
  Deals the cards into the players' hands, and updates `valid_moves` after dealing

  This will return an error if the table is not in a valid state to deal the cards, like the middle of a hand.
  """
  @callback deal(Table.t()) :: modifier_result()

  @doc """
  Processes a move on the table, and then updates `valid_moves`

  This will return an error if the table is not in a valid state to deal the cards, like the middle of a hand.
  """
  @callback play(Table.t(), Move.t()) :: modifier_result()

  @doc """
  Puts all cards back in the deck, removing them from anywhere else on the table.

  This will return an error if the table is not in a valid state to collect the cards, like the middle of a hand.
  """
  @callback collect_deck(Table.t()) :: modifier_result()

  @doc """
  Puts the current trick in the winning player's taken tricks, only valid if the current trick is full.
  """
  @callback collect_trick(Table.t()) :: modifier_result()

  @doc """
  Used internally to update the the Table's `valid_moves` after a state transformation.
  """
  @callback valid_moves(Table.t()) :: {:ok, list(Move.t())} | {:error, String.t()}

  @doc """
  Returns the index of the card that is currently winning the trick. If the trick is full, this returned index can
  be used to calculate which player won the trick.
  """
  @callback trick_winning_card(Table.t()) :: integer()
end
