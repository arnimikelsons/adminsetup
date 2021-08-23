# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :adminsetup,
  ecto_repos: [Adminsetup.Repo]

# Configures the endpoint
config :adminsetup, AdminsetupWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wFRMBnq8/O3SMPKtUWLAYpbU3C2gGYf6jcqFcVkGnuy8BP3kHztUBVXBDmGP/zRW",
  render_errors: [view: AdminsetupWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Adminsetup.PubSub,
  live_view: [signing_salt: "kTXJZD26"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
