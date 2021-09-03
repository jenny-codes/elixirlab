import Config

# ------------------------------------------
# DB layer

config :elixir_lab, ElixirLab.Repo,
  database: "elixir_lab",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :elixir_lab, ecto_repos: [ElixirLab.Repo]

# ------------------------------------------
# Web layer

config :elixir_lab, ElixirLab.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YEK2OD5ChMA1tDV1/Ehaayng7JJTouCbgyOYk/pCkyfUnjnHaRFHi32z+BLe7QU8",
  render_errors: [view: ElixirLab.Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirLab.PubSub,
  live_view: [signing_salt: "u/9NsKaF"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :elixir_lab, ElixirLab.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# ------------------------------------------
# Misc

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
