# Tefla

Prerequisites:
  * Install `asdf`: https://github.com/asdf-vm/asdf
  * Make sure you have the tool in `.tool-versions` up to date with `asdf`

To start your Tefla web server:

  * Install javascript dependencies with `cd assets && npm install && cd ..`
  * Install Elixir dependencies with `mix deps.get`
  * Make sure postgres is running `pg_ctl start`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Phoenix docs

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
