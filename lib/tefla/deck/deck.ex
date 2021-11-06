defmodule Tefla.Deck do
  use TypedStruct

  alias Tefla.Deck
  alias Tefla.Deck.Card

  typedstruct do
    @typedoc "A deck of cards"

    field :cards, list(Card.t()), enforce: true
  end

  @suits [:club, :diamond, :heart, :spade]
  @aces_high_faces [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]

  @standard_aces_high Enum.flat_map(@suits, fn s ->
    for ({f, i} <- Enum.with_index(@aces_high_faces)) do
      %Card{suit: s, face: f, rank: i}
    end
  end)

  def standard do
    %Deck{ cards: @standard_aces_high }
  end

  def shuffle(%Deck{cards: cards}) do
    %Deck{cards: Enum.shuffle(cards)}
  end

  def top_card(%Deck{cards: [first | _rest]}) do
    first
  end

end
