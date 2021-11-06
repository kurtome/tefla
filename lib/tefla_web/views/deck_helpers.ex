defmodule TeflaWeb.DeckHelpers do
  @moduledoc """
  Conveniences for rendering decks and cards.
  """

  use Phoenix.HTML
  alias Tefla.Deck.Card


  # Values from sprite sheet specs
  @height_px 450
  @width_px 318
  @row_gap_px 30
  @col_gap_px 25
  @suit_row %{
    diamond: 0,
    club: 1,
    heart: 2,
    spade: 3,
  }

  @doc """
  Generates a
  """
  def card_img(%Card{} = card) do
    tag(:img,
      alt: "#{card.face} of #{card.suit}",
      src: "https://cdn.trick.games/card_sprites.png",
      style: "height: #{@height_px}px; width: #{@width_px}px; object-fit: none; object-position: #{sprite_left(card)}px #{sprite_top(card)}px;"
    )
  end

  defp sprite_top(%Card{suit: suit}) do
    row = @suit_row[suit]
    -((row * @height_px) + (row * @row_gap_px))
  end

  defp sprite_left(%Card{rank: rank}) do
    -((rank * @width_px) + (rank * @col_gap_px))
  end
end
