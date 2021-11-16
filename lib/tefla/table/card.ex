defmodule Tefla.Table.Card do
  @moduledoc "A playing card."

  use TypedStruct

  typedstruct do
    field :suit, atom(), enforce: true
    field :face, atom(), enforce: true
  end
end
