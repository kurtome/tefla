defmodule Tefla.Table.Player do
  @moduledoc """
  Struct representing a single hand of playing cards.
  """

  alias Tefla.Table.Card
  use TypedStruct

  typedstruct do
    @typedoc "Struct for player"

    field :hand, list(Card.t()), enforce: true
  end

  @spec new() :: t()
  def new() do
    %__MODULE__{
      hand: []
    }
  end
end
