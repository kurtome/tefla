defmodule Tefla.GameRules.Standard do
  alias Tefla.Table.Deck
  alias Tefla.Table.Player
  alias Tefla.GameRules

  @behaviour GameRules

  @impl GameRules
  def new() do
    %Tefla.Table{
      deck: Deck.standard(),
      players: Enum.map(1..4, fn _ -> Player.new() end),
      trick: [],
      lead: 1,
      dealer: 0,
      valid_moves: []
    }
  end

  @impl GameRules
  def compare_cards(first, second) do
    first_face_i = Enum.find_index(Deck.aces_high_faces(), fn f -> f == first.face end)
    second_face_i = Enum.find_index(Deck.aces_high_faces(), fn f -> f == second.face end)

    cond do
      first_face_i == second_face_i ->
        first_suit_i = Enum.find_index(Deck.suits(), fn f -> f == first.suit end)
        second_suit_i = Enum.find_index(Deck.suits(), fn f -> f == second.suit end)
        first_suit_i <= second_suit_i

      true ->
        first_face_i <= second_face_i
    end
  end

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
