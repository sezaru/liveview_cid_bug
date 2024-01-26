import Config

config :marketplace, MarketplaceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: MarketplaceWeb.ErrorHTML, json: MarketplaceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Marketplace.PubSub,
  live_view: [signing_salt: "t54zMz33"]

config :phoenix, :json_library, Jason

import_config "phoenix/#{config_env()}.exs"
