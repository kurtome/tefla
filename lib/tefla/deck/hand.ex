defmodule Tefla.Deck.Hand do
  @moduledoc """
  Struct representing a single hand of playing cards.
  """

  use TypedStruct

  typedstruct do
    @typedoc "A hand"

    field :cards, atom(), enforce: true
  end
end
