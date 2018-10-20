# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nonpandoras,
  environment: Mix.env(),
  ecto_repos: [Nonpandoras.Repo],
  uploads_dir: Path.expand("./uploads"),
  admin_auth: [
    username: "admin",
    password: "123123",
    realm: "Admin Area"
  ]

# Configures the endpoint
config :nonpandoras, NonpandorasWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YPc7WcnnhquYupl8Wy7AEzmnlz56MEd5gjE5VxAEOuon6PTZUfcHq8n7M4mxChoB",
  render_errors: [view: NonpandorasWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nonpandoras.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Slim templates
config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :phoenix, :json_library, Jason

config :phoenix_slime, :use_slim_extension, true

# Storage
config :arc,
  storage: Arc.Storage.LocalUrl

# Pagination
config :scrivener_html, view_style: :semantic

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
