defmodule Tefla.Table.Move do
  @moduledoc """
  Struct representing a single hand of playing cards.
  """

  use TypedStruct

  typedstruct do
    @typedoc "Struct for player"

    field :player, integer(), enforce: true
    field :hand_card, integer(), enforce: true
  end
end
