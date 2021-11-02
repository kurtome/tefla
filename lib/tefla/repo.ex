defmodule Tefla.Repo do
  use Ecto.Repo,
    otp_app: :tefla,
    adapter: Ecto.Adapters.Postgres
end
