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

    # current trick being played, with most recently player on top
    field :trick, list(Card.t()), enforce: true

    # which player has the lead
    field :lead, integer(), enforce: true

    # which player is the dealer
    field :dealer, integer(), enforce: true

    # which player is the dealer
    field :valid_moves, list(Move.t()), enforce: true
  end

  @doc """
  The index of the current player's turn.
  This is calculated from whose lead it is and the current trick.
  """
  @spec current_turn(t()) :: integer
  def current_turn(%__MODULE__{lead: lead, trick: trick, players: players}) do
    rem(lead + length(trick), length(players))
  end

  @doc """
  Lead card of the current trick, or nil if none played.
  """
  @spec lead_card(t()) :: Card.t() | nil
  def lead_card(%__MODULE__{trick: trick}), do: Enum.at(trick, -1)

  @doc """
  Returns a list of the currently played cards for each player, at the player's index. The value at the player's index
  will be nil if they haven't played in the current trick.
  """
  @spec players_trick_cards(t()) :: [Card.t() | nil]
  def players_trick_cards(%__MODULE__{trick: trick, lead: lead} = table) do
    num_players = length(table.players)

    0..(num_players - 1)
    |> Enum.map(fn player_i ->
      card_i = rem(num_players + (player_i - lead), num_players)
      Enum.at(trick, card_i)
    end)
  end

  @doc """
  Calculate the index of one player relative to another.
  """
  @spec player_index(t(), integer(), integer()) :: integer()
  def player_index(%__MODULE__{players: players}, start_index, offset) do
    rem(start_index + offset, length(players))
  end

  @doc """
  Number of cards remaining in hand
  """
  @spec hand_cards_remaining(t()) :: integer()
  def hand_cards_remaining(%__MODULE__{players: players}) do
    Enum.map(players, fn p -> length(p.hand) end) |> Enum.sum()
  end

  @doc """
  Whether or not a hand is currently being played
  """
  @spec hand_in_progress?(t()) :: boolean()
  def hand_in_progress?(table) do
    hand_cards_remaining(table) > 0
  end

  @doc """
  Whether or not a all players have already played in the current trick
  """
  @spec trick_full?(t()) :: boolean()
  def trick_full?(table) do
    length(table.trick) == length(table.players)
  end
end
