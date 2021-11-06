defmodule Tefla.Deck.Card do
  @moduledoc """
  Struct representing a single playing card.
  """

  use TypedStruct

  typedstruct do
    @typedoc "A card"

    field :suit, atom(), enforce: true
    field :face, atom(), enforce: true
  end
end
