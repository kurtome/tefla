defmodule Tefla.GameRules.Standard do
  alias Tefla.Table
  alias Tefla.Table.Deck
  alias Tefla.GameRules

  @behaviour GameRules

  @impl GameRules
  def deal(table) when length(table.deck) == 52 do
    num_players = length(table.players)

    {dealt_hands, leftover} =
      Deck.shuffle(table.deck)
      |> Deck.deal(num_players)

    players =
      Enum.zip(table.players, dealt_hands)
      |> Enum.map(fn {p, h} -> %{p | hand: h} end)

    {:ok,
     %Table{
       deck: leftover,
       players: players,
       trick: [],
       lead: rem(table.dealer + 1, num_players),
       dealer: table.dealer
     }}
  end

  def deal(%Table{}), do: {:error, :invalid_input}

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
