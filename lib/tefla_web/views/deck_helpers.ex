defmodule TeflaWeb.DeckHelpers do
  @moduledoc """
  Conveniences for rendering decks and cards.
  """

  use Phoenix.HTML
  alias Tefla.Table.Card

  # Values from sprite sheet specs
  @height_px 450
  @width_px 318
  @row_gap_px 30
  @col_gap_px 25
  @suit_row %{
    diamonds: 0,
    clubs: 1,
    hearts: 2,
    spades: 3
  }
  @face_col %{
    two: 0,
    three: 1,
    four: 2,
    five: 3,
    six: 4,
    seven: 5,
    eight: 6,
    nine: 7,
    ten: 8,
    jack: 9,
    queen: 10,
    king: 11,
    ace: 12
  }

  @doc """
  Generates a card element.
  """
  def card_img(%Card{} = card) do
    card_img_row_col(@suit_row[card.suit], @face_col[card.face],
      alt: "#{card.face} of #{card.suit}"
    )
  end

  def card_back() do
    card_img_row_col(2, 13, alt: "Card")
  end

  defp card_img_row_col(row, col, opts) do
    alt = Keyword.get(opts, :alt, nil)

    content_tag(
      :div,
      tag(:img,
        alt: alt,
        src: "https://cdn.trick.games/card_sprites.png",
        style:
          "height: #{@height_px}px; width: #{@width_px}px; object-fit: none; object-position: #{sprite_left(col)}px #{sprite_top(row)}px;"
      ),
      class: "bg-white rounded border border-black",
      style: "height: #{@height_px}px; width: #{@width_px}px;"
    )
  end

  defp sprite_top(row) do
    -(row * @height_px + row * @row_gap_px)
  end

  defp sprite_left(col) do
    -(col * @width_px + col * @col_gap_px)
  end
end
