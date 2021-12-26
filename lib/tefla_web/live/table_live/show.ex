defmodule TeflaWeb.TableLive.Show do
  use TeflaWeb, :live_view

  import TeflaWeb.TableLive.Components

  alias Tefla.Table
  alias Tefla.GameRules.Standard

  require Logger

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Table Prototype")
     |> assign(:table, Standard.new())
     |> assign(:player_i, Map.get(session, "player_i", 0))
     |> assign_players()}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("deal", _value, socket) do
    if not Table.hand_in_progress?(socket.assigns.table) do
      {:ok, table} = Standard.deal(socket.assigns.table)
      {:noreply, assign(socket, :table, table)}
    else
      Logger.warn("Already dealt, ignoring event.")
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("play_card", move_params, socket) do
    with {:ok, move} <- Tefla.Table.Move.from_params(move_params),
         {:ok, table} <- Standard.play(socket.assigns.table, move) do
      {:noreply, assign(socket, :table, table)}
    else
      {:error, errors} ->
        Logger.warn("Invalid move. #{inspect(errors)}")
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("collect_trick", _, socket) do
    with {:ok, table} <- Standard.collect_trick(socket.assigns.table) do
      {:noreply, assign(socket, :table, table)}
    else
      {:error, errors} ->
        Logger.warn("Invalid move. #{inspect(errors)}")
        {:noreply, socket}
    end
  end

  defp assign_players(socket) do
    table = socket.assigns.table
    player_i = socket.assigns.player_i

    socket
    |> assign(:player_left_i, Table.player_index(table, player_i, 1))
    |> assign(:player_top_i, Table.player_index(table, player_i, 2))
    |> assign(:player_right_i, Table.player_index(table, player_i, 3))
  end
end
