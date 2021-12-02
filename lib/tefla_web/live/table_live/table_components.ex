defmodule TeflaWeb.TableLive.Components do
  use Phoenix.Component

  import TeflaWeb.DeckHelpers

  @doc """
  Assigns:
   - table
   - player
   - class, additional css classes to add to the root element
   - vertical, whether or not to render the hand vertically (default false)
  """
  def hand(assigns) do
    assigns = assign_new(assigns, :class, fn -> "" end)
    assigns = assign_new(assigns, :vertical, fn -> false end)
    assigns = assign(assigns, :player, Enum.at(assigns.table.players, assigns.player_i))

    {:ok, valid_moves} = Tefla.GameRules.Standard.valid_moves(assigns.table)
    current_turn = Tefla.Table.current_turn(assigns.table)

    flex_direction = if(assigns[:vertical], do: "flex-col", else: "flex-row")
    size_constraint = if(assigns[:vertical], do: "h-8", else: "w-8")

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
end
