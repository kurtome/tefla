defmodule TeflaWeb.PageControllerTest do
  use TeflaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "two of hearts"
  end
end
