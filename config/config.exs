# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :fomantic_ui,
  namespace: FomanticUI

# Configures the endpoint
config :fomantic_ui, FomanticUI.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gSj0h6TzWOJbzU4jkZRIYmULke5O+j46IA6SB6TeB3VNcWfQmGoCEJL6cL5LVlP4",
  render_errors: [view: FomanticUI.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: FomanticUI.PubSub,
  live_view: [signing_salt: "GZD92ddr"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.13.10",
  default: [
    args: ~w(
      js/app.js
      --bundle
      --loader:.png=dataurl
      --loader:.svg=dataurl
      --loader:.eot=dataurl
      --loader:.ttf=dataurl
      --loader:.woff=dataurl
      --loader:.woff2=dataurl
      --target=es2018
      --outdir=../priv/static/assets
    ),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
