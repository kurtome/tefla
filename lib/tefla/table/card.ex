defmodule Tefla.Table.Card do
  @moduledoc "A playing card."

  use TypedStruct

  typedstruct do
    field :face, atom(), enforce: true
    field :suit, atom(), enforce: true
  end

  @spec new(atom(), atom()) :: t()
  def new(face, suit), do: %__MODULE__{face: face, suit: suit}
end
