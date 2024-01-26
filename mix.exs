defmodule Marketplace.MixProject do
  @moduledoc false

  use Mix.Project

  @version "1.18.0"

  def project do
    [
      app: :marketplace,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Marketplace.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # Ash framework
      {:ash, "~> 2.15", override: true},
      {:ash_query_builder, "~> 0.6.2"},

      # Phoenix
      {:phoenix, "~> 1.7.2"},
      {:phx_component_helpers, "~> 1.3"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.20"},
      {:cors_plug, "~> 3.0"},
      {:plug_cowboy, "~> 2.5"},

      # LiveView
      {:phoenix_live_view, "~> 0.20", override: true},
      {:phoenix_live_dashboard, "~> 0.7"},
      {:heroicons, "~> 0.5"},
      {:petal_components, "~> 1.5"},

      # Utils
      {:typedstruct, "~> 0.5.0", runtime: false}
    ]
  end
end
