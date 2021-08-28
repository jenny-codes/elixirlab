use Mix.Config

config :elixir_lab, ElixirLab.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixir_lab_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :elixir_lab, experiment_repo: ElixirLab.Lab.MockExperimentRepo

config :logger, level: :info
