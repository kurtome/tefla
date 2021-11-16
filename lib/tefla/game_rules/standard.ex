defmodule Tefla.GameRules.Standard do
  alias Tefla.Table.Deck
  alias Tefla.GameRules

  @behaviour GameRules

  @impl GameRules
  def deal(_)

  def deal(table) when length(table.deck) != 52, do: {:error, "deal: deck must have 52 cards"}

  def deal(table) when length(table.players) != 4, do: {:error, "deal: table must have 4 players"}

  def deal(table) when length(table.deck) == 52 and length(table.players) == 4 do
    num_players = length(table.players)

    {dealt_hands, leftover} =
      Deck.shuffle(table.deck)
      |> Deck.deal(num_players)

    players =
      Enum.zip(table.players, dealt_hands)
      |> Enum.map(fn {p, h} -> %{p | hand: h} end)

    {:ok, %{table | deck: leftover, players: players, lead: rem(table.dealer + 1, num_players)}}
  end

  def deal(_), do: {:error, "deal: invalid table"}

  @impl GameRules
  def move(table, _move) do
    table
  end

  @impl GameRules
  def collect_deck(table) do
    table
  end

  @impl GameRules
  def valid_moves(_table) do
    []
  end
end
