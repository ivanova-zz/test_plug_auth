defmodule TestPlugAuth.MixProject do
  use Mix.Project

  def project do
    [
      app: :test_plug_auth,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:cowboy, "~> 2.9"},
      {:plug, "~> 0.14 or ~> 1.0"}]
  end

  defp package do
    [
      contributors: ["Yuliia Ivanova"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/ivanova-zz/test_plug_auth"},
      files: ~w(lib mix.exs README.md)
    ]
  end
end
