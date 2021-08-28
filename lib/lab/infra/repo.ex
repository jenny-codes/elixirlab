defmodule ElixirLab.Repo do
  use Ecto.Repo,
    otp_app: :elixir_lab,
    adapter: Ecto.Adapters.Postgres
end
