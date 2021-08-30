use Mix.Config

config :elixir_lab, ElixirLab.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixir_lab_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :elixir_lab, experiment_repo: ElixirLab.MockExperimentRepo

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_lab, ElixirLab.Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  server: false

# In test we don't send emails.
config :elixir_lab, ElixirLab.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :logger, level: :info
