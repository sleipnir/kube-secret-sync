defmodule Kss.MixProject do
  use Mix.Project

  @app :kss
  @version "0.1.0"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Kss.Application, [env: Mix.env()]}
    ]
  end

  def deps do
    [
      {:bonny, "~> 1.4"},
      {:k8s_webhoox, "~> 0.2.0"},
      {:libvault, "~> 0.2"},
      {:tesla, "~> 1.3"},
      {:mint, "~> 1.0"},
      {:castore, "~> 1.0"},
      {:jason, "~> 1.3"}
    ]
  end

  defp releases do
    [
      kss: [
        include_executables_for: [:unix],
        applications: [kss: :permanent],
        steps: [
          :assemble,
          &Bakeware.assemble/1
        ],
        bakeware: [compression_level: 19]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["test/support" | elixirc_paths(:prod)]
  defp elixirc_paths(_), do: ["lib"]
end
