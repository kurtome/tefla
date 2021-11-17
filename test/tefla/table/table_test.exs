defmodule Tefla.Table.TableTest do
  use ExUnit.Case, async: true

  alias Tefla.Table.Deck
  alias Tefla.GameRules.Standard

  test "deal 4 hands, full deck" do
    table =
      Standard.new()
      |> Standard.deal()

    {[hand1, hand2, hand3, hand4], leftover} = Deck.deal(deck, 4)
    assert length(hand1) == 13
  end
end
