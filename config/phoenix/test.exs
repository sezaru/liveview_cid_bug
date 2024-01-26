import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :marketplace, MarketplaceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AJxyvBdVask9v92NbrEOP8hJlYzY1Lzb2MNQz9CJvHCOlq+CK6xguFNgsrXU4vKq",
  server: false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
