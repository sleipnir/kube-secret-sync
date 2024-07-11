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
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Kss.Application, []}
    ]
  end

  def deps do
    [
      {:bonny, "~> 1.4"},
      {:libvault, "~> 0.2"},
      {:tesla, "~> 1.3"},
      {:mint, "~> 1.0"},
      {:castore, "~> 1.0"},
      {:jason, "~> 1.3"}
    ]
  end
end
