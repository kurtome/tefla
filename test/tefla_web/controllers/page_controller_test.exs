defmodule TeflaWeb.PageControllerTest do
  use TeflaWeb.ConnCase

  alias Tefla.Table.Deck.MockShuffler

  test "GET /", %{conn: conn} do
    Mox.stub(MockShuffler, :shuffle, &Function.identity/1)
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "two of hearts"
  end
end
