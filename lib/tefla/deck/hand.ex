defmodule Tefla.Deck.Hand do
  @moduledoc """
  Struct representing a single hand of playing cards.
  """

  alias Tefla.Deck.Card

  @type t :: list(Card.t())

  def empty(), do: []
end
