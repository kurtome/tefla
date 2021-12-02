defmodule TeflaWeb.DeckHelpers do
  @moduledoc """
  Conveniences for rendering decks and cards.
  """

  use Phoenix.HTML
  alias Tefla.Table.Card

  def card_back(opts \\ []) do
    make_card_img("https://cdn.trick.games/cards_default/back.svg", opts)
  end

  @doc """
  Generates a card element.
  """
  def card_img(%Card{} = card, opts \\ []) do
    make_card_img(
      "https://cdn.trick.games/cards_default/#{card.face}_of_#{card.suit}.svg",
      Keyword.merge(opts, alt: "#{card.face} of #{card.suit}")
    )
  end

  defp make_card_img(url, opts) when is_binary(url) do
    alt = Keyword.get(opts, :alt, nil)
    img_class = Keyword.get(opts, :img_class, "")

    content_tag(
      :div,
      tag(:img,
        alt: alt,
        src: url,
        class: "w-full #{img_class}"
      ),
      class: "relative w-24"
    )
  end
end
