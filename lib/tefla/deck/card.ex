defmodule Tefla.Deck.Card do
  use TypedStruct

  typedstruct do
    @typedoc "A card"

    field :suit, atom(), enforce: true
    field :face, atom(), enforce: true
    field :rank, integer(), enforce: true
  end
end
