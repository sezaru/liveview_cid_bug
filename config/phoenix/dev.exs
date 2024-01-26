import Config

config :marketplace, MarketplaceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "hJbdgai0AfH/+r4Wdy7Lwwfkw7aEgeneUX6MignAOTDXJa9JFyLz3Pd5ag44GHZq",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

config :marketplace, MarketplaceWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/marketplace_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

# Enable HEEX debug annotations
config :phoenix_live_view, :debug_heex_annotations, true

# Enable dev routes for dashboard and mailbox
config :marketplace, dev_routes: true

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 100
