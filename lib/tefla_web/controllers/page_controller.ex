defmodule TeflaWeb.PageController do
  use TeflaWeb, :controller

  def index(conn, _params) do
    deck =
      Tefla.Deck.standard()
      |> Tefla.Deck.shuffle()

    conn
    |> assign(:deck, deck)
    |> render("index.html")
  end
end
