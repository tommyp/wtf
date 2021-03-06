# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wtf,
  ecto_repos: [Wtf.Repo]

# Configures the endpoint
config :wtf, WtfWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "brkBxaJRqdWZOqYvwqBExQOMlSa0+E0xW/sObZJ4TVktCmoYSKlr7etWWAvNSPLt",
  render_errors: [view: WtfWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wtf.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "I66bOUA6UGBK1LDjtkxhXjDqd3zKdXGi"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

config :geonames,
  username: "tommypdev",
  language: "en"

config :bees,
  foursquare_client_id: "AQIKJSHEIUF4AETDY0DJ4AOSMXCUW1VPDNCHHGOLL2DRELUT",
  foursquare_client_secret: "XSAATNK3DPMGYL2L14OZTYWAF1K3WXE1PIYED0SVLEQWNA2Q"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
