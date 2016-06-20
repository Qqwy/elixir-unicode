defmodule Unicode.CompiletimeHelper do
  @moduledoc false

  @doc false
  # Parses format like:
  #
  # 002B          ; Math # Sm       PLUS SIGN
  # 003C..003E    ; Math # Sm   [3] LESS-THAN SIGN..GREATER-THAN SIGN
  def split_derived_core_properties_line(raw_line) do
    raw_line
    |> String.split("#") # comments
    |> List.first
    |> String.split(";") # Delimiter between codepoint (range) and property name.
    |> Enum.map(&String.strip/1)
  end

  def split_block_line(raw_line) do
    raw_line
    |> String.split(";")
    |> Enum.map(&String.strip/1)
  end
  def normalize_block_name(block_name) do
    block_name
    |> String.replace(" ", "")
    |> String.replace("_", "")
    |> String.replace("-", "")
    |> String.downcase
  end
end