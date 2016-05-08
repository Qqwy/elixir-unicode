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

  defp description
  """
  The _Unicode_ package provides functionality to check properties of unicode codepoints, graphemes and strings.

  This is often useful when checking or validating the contents of strings in sitiations where using Regular Expressions is not necessary and/or too slow. 

  The Unicode package is based on Version 8.0.0 of the Unicode standard.
  """
  end

  defp package
    name: :unicode,
   files: ["lib", "unicode_source_files", "mix.exs", "README*", "LICENSE*", "license*"],

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
    []
  end
end
