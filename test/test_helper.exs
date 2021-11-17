ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Tefla.Repo, :manual)

alias Tefla.Table.Deck.Shuffler
alias Tefla.Table.Deck.MockShuffler
Mox.defmock(MockShuffler, for: Shuffler)
Application.put_env(:tefla, :deck_shuffler, MockShuffler)
