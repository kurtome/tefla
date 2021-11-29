defmodule TeflaWeb.DeckHelpers do
  @moduledoc """
  Conveniences for rendering decks and cards.
  """

  use Phoenix.HTML
  alias Tefla.Table.Card

  def card_back() do
    content_tag(
      :div,
      tag(:img,
        alt: "face down card",
        src: "https://cdn.trick.games/cards_default/back.svg",
        class: "w-full"
      ),
      class: "w-48"
    )
  end

  @doc """
  Generates a card element.
  """
  def card_img(%Card{} = card) do
    alt = "#{card.face} of #{card.suit}"

    content_tag(
      :div,
      tag(:img,
        alt: alt,
        src: "https://cdn.trick.games/cards_default/#{card.face}_of_#{card.suit}.svg",
        class: "w-full"
      ),
      class: "w-48"
    )
  end
end
