import Config

config :elixir_lab, ElixirLab.Repo,
  database: "elixir_lab",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :elixir_lab, ecto_repos: [ElixirLab.Repo]

config :elixir_lab, experiment_repo: ElixirLab.Lab.Adapter.EexperimentRepo

import_config "#{Mix.env()}.exs"
