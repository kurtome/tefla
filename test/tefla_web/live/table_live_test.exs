defmodule TeflaWeb.TableLiveTest do
  use TeflaWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Show" do
    test "displays table", %{conn: conn} do
      {:ok, _show_live, html} = live(conn, Routes.table_show_path(conn, :show))

      assert html =~ "Table Prototype"
    end
  end
end
