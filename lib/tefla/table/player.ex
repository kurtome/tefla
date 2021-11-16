defmodule Tefla.Table.Player do
  @moduledoc """
  Player in a `Tefla.Table` card game.
  """

  alias Tefla.Table.Card
  use TypedStruct

  typedstruct do
    @typedoc """
    hand: cards in the player's hand
    tricks_taken: cards in the player's hand
    """

    field :hand, list(Card.t()), enforce: true
    field :tricks_taken, list(list(Card.t())), enforce: true
  end

  @spec new() :: t()
  def new() do
    %__MODULE__{
      hand: [],
      tricks_taken: []
    }
  end
end
