defprotocol Tefla.GameRules do
  @moduledoc """
  Defines valid state transitions for a `Tefla.Table`. Implementations of this protocol represent a game conventional
  card game, like: bridge, whist, spades, hearts, etc.
  """

  alias Tefla.Table
  alias Tefla.Table.Move

  @typep modifier_result :: {:ok, Table.t()} | {:error, String.t()}

  @doc """
  Deals the cards into the players' hands, and updates `valid_moves` after dealing

  This will return an error if the table is not in a valid state to deal the cards, like the middle of a hand.
  """
  @callback deal(Table.t()) :: modifier_result()

  @doc """
  Processes a move on the table, and then updates `valid_moves`

  This will return an error if the table is not in a valid state to deal the cards, like the middle of a hand.
  """
  @callback move(Table.t(), Move.t()) :: modifier_result()

  @doc """
  Puts all cards back in the deck, removing them from anywhere else on the table.

  This will return an error if the table is not in a valid state to collect the cards, like the middle of a hand.
  """
  @callback collect_deck(Table.t()) :: modifier_result()

  @doc """
  Used internally to update the the Table's `valid_moves` after a state transformation.
  """
  @callback valid_moves(Table.t()) :: list(Move.t())
end
