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

  @spec new(integer(), integer()) :: t()
  def new(player, hand_card), do: %__MODULE__{player: player, hand_card: hand_card}
end
