defmodule Tefla.GameRules.Standard do
  alias Tefla.Table
  alias Tefla.Table.Card
  alias Tefla.Table.Deck
  alias Tefla.Table.Player
  alias Tefla.Table.Move
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
  def compare_cards(first, second, opts \\ []) do
    suit_first? = Keyword.get(opts, :suit_first?, false)
    first_face_i = Enum.find_index(Deck.aces_high_faces(), fn f -> f == first.face end)
    second_face_i = Enum.find_index(Deck.aces_high_faces(), fn f -> f == second.face end)
    first_suit_i = Enum.find_index(Deck.suits(), fn f -> f == first.suit end)
    second_suit_i = Enum.find_index(Deck.suits(), fn f -> f == second.suit end)

    cond do
      suit_first? and first_suit_i != second_suit_i ->
        first_suit_i <= second_suit_i

      first_face_i == second_face_i ->
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

    dealt_hands =
      Enum.map(dealt_hands, fn h ->
        Enum.sort(h, fn a, b -> compare_cards(a, b, suit_first?: true) end)
      end)

    players =
      Enum.zip(table.players, dealt_hands)
      |> Enum.map(fn {p, h} -> %{p | hand: h} end)

    {:ok, %{table | deck: leftover, players: players, lead: rem(table.dealer + 1, num_players)}}
  end

  def deal(_), do: {:error, "deal: invalid table"}

  @impl GameRules
  def play(table, move) do
    {:ok, valid_moves} = __MODULE__.valid_moves(table)

    cond do
      !Enum.any?(valid_moves, fn vm -> vm == move end) ->
        {:error, "move must be valid"}

      true ->
        player = Enum.at(table.players, move.player)
        card = Enum.at(player.hand, move.hand_card)
        trick = table.trick ++ [card]
        hand = List.delete_at(player.hand, move.hand_card)

        table = %{
          table
          | trick: trick,
            players:
              List.update_at(table.players, move.player, fn _ -> %{player | hand: hand} end)
        }

        {:ok, table}
    end
  end

  @impl GameRules
  def collect_deck(table) do
    {:ok, table}
  end

  @impl GameRules
  def collect_trick(table) do
    if !Table.trick_full?(table) do
      {:error, "trick must be finished to collect it"}
    else
      winning_card_i = trick_winning_card(table)
      num_players = length(table.players)
      winning_player_i = rem(table.lead + winning_card_i, num_players)
      player = Enum.at(table.players, winning_player_i)
      tricks_taken = [table.trick | player.tricks_taken]

      table = %{
        table
        | lead: winning_player_i,
          trick: [],
          players:
            List.update_at(table.players, winning_player_i, fn _ ->
              %{player | tricks_taken: tricks_taken}
            end)
      }

      {:ok, table}
    end
  end

  @impl GameRules
  def valid_moves(table) do
    p = Table.current_turn(table)
    player = Enum.at(table.players, p)
    player_moves = Enum.with_index(player.hand, fn _, i -> Move.new(p, i) end)

    case {Table.trick_full?(table), Table.lead_card(table)} do
      {true, _} ->
        # If the trick is full, there are no legal moves.
        {:ok, []}

      {_, nil} ->
        if table.lead != p do
          {:error, "current player must be lead if no card played yet in trick"}
        else
          {:ok, player_moves}
        end

      {_, %Card{suit: suit}} ->
        moves =
          Enum.filter(player_moves, fn move ->
            card = Enum.at(player.hand, move.hand_card)
            card.suit == suit
          end)

        case moves do
          [] ->
            # if a player cannot follow suit, they can play any card in their hand
            {:ok, player_moves}

          _ ->
            {:ok, moves}
        end
    end
  end

  @impl GameRules
  def trick_winning_card(table) do
    lead_card = Table.lead_card(table)

    {_card, i} =
      Enum.with_index(table.trick)
      |> Enum.reduce({nil, nil}, fn {card, i}, {max, max_i} ->
        cond do
          is_nil(lead_card) -> {nil, nil}
          is_nil(max) -> {card, i}
          card.suit == lead_card.suit and compare_cards(max, card) -> {card, i}
          true -> {max, max_i}
        end
      end)

    i
  end
end
