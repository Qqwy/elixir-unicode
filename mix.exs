defmodule Unicode.Mixfile do
  use Mix.Project

  def project do
    [app: :unicode,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  defp description do
  """
  The _Unicode_ package provides functionality to check properties of unicode codepoints, graphemes and strings.

  This is often useful when checking or validating the contents of strings in situations where using Regular Expressions is not necessary and/or too slow. 

  The Unicode package is based on Version 8.0.0 of the Unicode standard.
  """
  end

  defp package do
    [
      name: :unicode,
      files: ["lib", "unicode_source_files", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Qqwy/Wiebe-Marten Wijnja"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/Qqwy/elixir-unicode",
        "Docs" => "https://hexdocs.pm/unicode/0.0.1"
      }
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.11.5", only: [:dev]},
      {:earmark, ">= 0.2.1"}
    ]
  end
end
