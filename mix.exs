defmodule FirestormData.MixProject do
  use Mix.Project

  @version "0.1.1"
  @description """
  FirestormData is the data layer for the Firestorm Forum.
  """

  def project do
    [
      app: :firestorm_data,
      package: package(),
      description: @description,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),
      source_url: "https://www.github.com/dailydrip/firestorm_data",
      homepage_url: "https://www.firestormforum.org",
      deps: deps()
    ]
  end

  defp package do
    [
      maintainers: ["Josh Adams"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/dailydrip/firestorm_data",
        "Website" => "https://www.firestormforum.org"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FirestormData.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, ">= 0.3.5"},
      {:scrivener_ecto, "~> 1.3"},
      {:ecto_autoslug_field, "~> 0.5"},
      {:uuid, "~> 1.1"},
      {:timex, "~> 3.3"},
      {:comeonin, "~> 4.1"},
      {:bcrypt_elixir, "~> 1.0"},
      ### DEVELOPMENT AND TEST DEPENDENCIES
      # We want to use factories to create test data
      {:ex_machina, "~> 2.2", only: :test},
      # We want reasonable-ish fake data
      {:faker, "~> 0.10", only: :test},
      {:dialyxir, "~> 0.5.1", only: [:dev, :test]},
      # Generate documentation
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end

  defp aliases do
    [
      test: ["ecto.drop", "ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
