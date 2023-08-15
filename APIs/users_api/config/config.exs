# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :users_api,
  ecto_repos: [UsersApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :users_api, UsersApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fXVt+GY1qT1+ZQOpcqD5oNUka7aePSrxV6TPP4JdCjPw4njVMvzcRNZJzJH9isIY",
  render_errors: [view: UsersApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: UsersApi.PubSub,
  live_view: [signing_salt: "aiFPEKHz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
