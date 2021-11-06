defmodule Tefla.Deck do
  @moduledoc """
  Struct for representing the state of a deck of cards.
  """

  use TypedStruct

  typedstruct do
    @typedoc "A deck of cards"

    field :cards, String.t(), enforce: true
  end
end
