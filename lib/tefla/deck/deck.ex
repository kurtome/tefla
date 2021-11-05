defmodule Tefla.Deck do
  use TypedStruct

  typedstruct do
    @typedoc "A deck of cards"

    field :cards, String.t(), enforce: true
  end
end
