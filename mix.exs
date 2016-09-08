defmodule ExModbus.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_modbus,
     version: "0.0.2",
     elixir: ">= 1.0.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :nerves_uart]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    #[{:serial, git: "https://github.com/bitgamma/elixir_serial", tag: "v0.1.2"}]
    [{:nerves_uart, git: "https://github.com/dhanson358/nerves_uart", }]
  end
end
