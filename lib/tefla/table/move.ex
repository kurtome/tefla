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

  @spec from_params(%{String.t() => String.t()}) :: {:ok, t()} | {:error, [any()]}
  def from_params(params) do
    import Ecto.Changeset

    changeset =
      {%{}, %{player: :integer, hand_card: :integer}}
      |> cast(params, [:player, :hand_card])
      |> validate_required([:player, :hand_card])
      |> validate_number(:player, greater_than_or_equal_to: 0)
      |> validate_number(:player, greater_than_or_equal_to: 0)

    if changeset.valid? do
      {:ok, %__MODULE__{player: changeset.changes.player, hand_card: changeset.changes.hand_card}}
    else
      {:error, changeset.errors}
    end
  end
end
