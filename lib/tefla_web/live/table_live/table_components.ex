defmodule TeflaWeb.TableLive.Components do
  use Phoenix.Component

  import TeflaWeb.DeckHelpers
  alias Tefla.Table

  @doc """
  Assigns:
   - table
   - player_i
   - class, additional css classes to add to the root element
   - vertical, whether or not to render the hand vertically (default false)
  """
  def hand(assigns) do
    assigns = assign_new(assigns, :class, fn -> "" end)
    assigns = assign_new(assigns, :vertical, fn -> false end)
    assigns = assign(assigns, :player, Enum.at(assigns.table.players, assigns.player_i))

    {:ok, valid_moves} = Tefla.GameRules.Standard.valid_moves(assigns.table)
    current_turn = Table.current_turn(assigns.table)

    flex_direction = if(assigns[:vertical], do: "flex-col", else: "flex-row")
    size_constraint = if(assigns[:vertical], do: "h-6", else: "w-6 md:w-8 lg:w-12")

    ~H"""
    <div class={"flex #{flex_direction} #{@class}"} >
      <%= for {card, card_i} <- Enum.with_index(@player.hand) do %>
        <% playable? = Enum.any?(valid_moves, fn m -> m.player == @player_i and m.hand_card == card_i end) %>
        <div
                phx-click="play_card"
                phx-value-player={@player_i}
                phx-value-hand_card={card_i}
                class={"#{size_constraint} #{if(playable?, do: "cursor-pointer")}"}>
            <%= if @player_i == current_turn do %>
               <%= card_img(card, img_class: if(playable?, do: "", else: "filter brightness-75")) %>
            <% else %>
                <%= card_back() %>
            <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  @doc """
  Assigns:
   - table
  """
  def trick(assigns) do
    trick_full? = Table.trick_full?(assigns.table)
    trick_winning_card = Tefla.GameRules.Standard.trick_winning_card(assigns.table) || 0
    played_cards = Table.players_trick_cards(assigns.table)
    lead = assigns.table.lead || 0
    winning_i = rem(trick_winning_card + lead, 4)

    [player_0_card, player_1_card, player_2_card, player_3_card] = played_cards

    ~H"""
    <div class="grid grid-rows-3 grid-cols-3 gap-1">
       <div></div>
       <div class="mx-auto">
         <.trick_card card={player_2_card} winning?={winning_i == 2}) trick_full?={trick_full?} />
       </div>
       <div></div>
       <div class="ml-auto">
         <.trick_card card={player_1_card} winning?={winning_i == 1} trick_full?={trick_full?} />
       </div>
       <div class="flex justify-center items-center">
         <%= if Table.trick_full?(@table) do %>
           <button class="rounded border border-black px-2" phx-click="collect_trick" >
             Collect
           </button>
         <% end %>
       </div>
       <div class="mr-auto">
         <.trick_card card={player_3_card} winning?={winning_i == 3} trick_full?={trick_full?} />
       </div>
       <div></div>
       <div class="mx-auto">
         <.trick_card card={player_0_card} winning?={winning_i == 0} trick_full?={trick_full?} />
       </div>
       <div></div>
    </div>
    """
  end

  @doc """
  Assigns:
   - winning?: is currently winning the trick
   - card
  """
  def trick_card(assigns) do
    card = assigns.card

    if is_nil(card) do
      ~H"""
        <div></div>
      """
    else
      ~H"""
       <%= if @winning? do %>
         <div class="cursor-pointer" phx-click="collect_trick" >
           <%= card_img(card, img_class: "shadow-lg shadow-blue-200") %>
         </div>
       <% else %>
         <%= card_img(card) %>
       <% end %>
      """
    end
  end

  @doc """
  Assigns:
   - table
   - player_i
  """
  def player_info(assigns) do
    player = Enum.at(assigns.table.players, assigns.player_i)

    ~H"""
    <div>
      <p class="font-bold">Player <%= @player_i %></p>
      <p>Tricks: <%= length(player.tricks_taken) %></p>
    </div>
    """
  end
end
