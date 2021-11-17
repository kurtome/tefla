defmodule Tefla.Table.TableTest do
  use ExUnit.Case, async: true

  alias Tefla.GameRules.Standard
  alias Tefla.Table
  alias Tefla.Table.Deck.MockShuffler

  test "current player" do
    Mox.stub(MockShuffler, :shuffle, &Function.identity/1)

    {:ok, table} =
      Standard.new()
      |> Standard.deal()

    assert table.dealer == 0
    assert table.lead == 1
    assert Table.current_turn(table) == 1
  end
end
