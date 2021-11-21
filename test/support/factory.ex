defmodule Tefla.Factory do
  # Currently we don't use this with Ecto, but we likely will later
  use ExMachina, repo: Tefla.Repo

  alias Tefla.Table
  alias Tefla.Table.Deck
  alias Tefla.GameRules

  @spec table_deal_factory :: Table.t()
  def table_deal_factory do
    shuffler = Application.get_env(:tefla, :deck_shuffler)

    try do
      Application.put_env(:tefla, :deck_shuffler, Deck.RandomShuffler)

      {:ok, table} =
        GameRules.Standard.new()
        |> GameRules.Standard.deal()

      table
    after
      Application.put_env(:tefla, :deck_shuffler, shuffler)
    end
  end

  @spec table_sorted_deal_factory :: Table.t()
  def table_sorted_deal_factory do
    shuffler = Application.get_env(:tefla, :deck_shuffler)

    try do
      Application.put_env(:tefla, :deck_shuffler, Deck.SortShuffler)

      {:ok, table} =
        GameRules.Standard.new()
        |> GameRules.Standard.deal()

      table
    after
      Application.put_env(:tefla, :deck_shuffler, shuffler)
    end
  end

  @spec table_identity_deal_factory :: Table.t()
  def table_identity_deal_factory do
    shuffler = Application.get_env(:tefla, :deck_shuffler)

    try do
      Application.put_env(:tefla, :deck_shuffler, Deck.IdentityShuffler)

      {:ok, table} =
        GameRules.Standard.new()
        |> GameRules.Standard.deal()

      table
    after
      Application.put_env(:tefla, :deck_shuffler, shuffler)
    end
  end
end
