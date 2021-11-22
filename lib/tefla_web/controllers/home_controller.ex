defmodule TeflaWeb.HomeController do
  use TeflaWeb, :controller

  def index(conn, _params) do
    deck =
      Tefla.Table.Deck.standard()
      |> Tefla.Table.Deck.shuffle()

    conn
    |> assign(:deck, deck)
    |> render("index.html")
  end
end
