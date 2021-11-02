defmodule TeflaWeb.PageController do
  use TeflaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
