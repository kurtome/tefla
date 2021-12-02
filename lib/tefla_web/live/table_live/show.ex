defmodule TeflaWeb.TableLive.Show do
  use TeflaWeb, :live_view

  import TeflaWeb.SharedComponents
  import TeflaWeb.TableLive.Components

  alias Tefla.Table
  alias Tefla.GameRules.Standard

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Table Prototype")
     |> assign(:table, Standard.new())
     |> assign(:player_i, 0)}
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
      Logger.info("Cast move: #{inspect(move)}")
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
end
