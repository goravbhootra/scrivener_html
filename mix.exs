defmodule ScrivenerHtml.Mixfile do
  use Mix.Project

  @version "2.0.0"
  def project do
    [
      app: :scrivener_html,
      version: @version,
      elixir: "~> 1.6",
      name: "scrivener_html",
      source_url: "https://github.com/goravbhootra/scrivener_html",
      homepage_url: "https://github.com/goravbhootra/scrivener_html",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "HTML helpers for Scrivener",
      docs: [
        main: Scrivener.HTML,
        readme: "README.md"
      ],
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

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
    [
      {:scrivener, "~> 2.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix, "~> 1.5 and < 1.7.0", optional: true},
      {:plug, "~> 1.5"},
      {:ex_doc, "~> 0.21", only: :dev},
      {:earmark, "~> 1.3", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Gorav Bhootra"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/goravbhootra/scrivener_html"}
    ]
  end

  defp aliases do
    [publish: ["hex.publish", "hex.publish docs", "tag"], tag: &tag_release/1]
  end

  defp tag_release(_) do
    Mix.shell().info("Tagging release as #{@version}")
    System.cmd("git", ["tag", "-a", "v#{@version}", "-m", "v#{@version}"])
    System.cmd("git", ["push", "--tags"])
  end
end
