defmodule TeflaWeb.PageController do
  use TeflaWeb, :controller

  def index(conn, _params) do
    deck = Tefla.Deck.standard()
    conn
    |> assign(:deck, deck)
    |> assign(:card, Enum.at(deck.cards, 0))
    |> render("index.html")
  end
end
