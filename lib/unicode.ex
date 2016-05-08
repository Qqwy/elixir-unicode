defmodule Unicode do
  alias Unicode.CompiletimeHelper

  @moduledoc """
  Provides functionality to efficiently check properties of Unicode codepoints, graphemes and strings.
  
  The current implementation is based on Unicode version _8.0.0_.

  """

  @derived_core_properties %{ 
    Math: :math, 
    Alphabetic: :alphabetic, 
    Lowercase: :lowercase, 
    Uppercase: :uppercase, 
    # Cased: :cased, 
    # Case_Ignorable: :case_ignorable, 
    # Changes_When_Lowercased: :changes_when_lowercased,
    # Changes_When_Titlecased: :changes_when_titlecased,
    # Changes_When_Casefolded: :changes_when_casefolded,
    # Changes_When_Casemapped: :changes_when_casemapped,
    # ID_Start: :id_start,
    # ID_Continue: :id_continue,
    # XID_Start: :xid_start,
    # XID_Continue: :xid_continue,
    # Default_Ignorable_Code_Point: :default_ignorable_code_point,
    # Grapheme_Extend: :grapheme_extend,
    # Grapheme_Base: :grapheme_base
  }



  # TODO: Add empty function heads and document them.

  @doc """
  Checks if a single Unicode codepoint (or all characters in the given binary string) adhere to the Derived Core Property `Math`.

  These are all characters whose primary usage is in mathematical concepts (and not in alphabets)
  The function takes a unicode codepoint or a string as input.

  For the string-version, the result will be true only if _all_ codepoints in the string adhere to the property.

  ## Examples

      iex>Unicode.math?(?=)
      true
      iex>Unicode.math?("=")
      true
      iex>Unicode.math?("1+1=2")
      true
      iex>Unicode.math?("camembert")
      false
      iex>Unicode.math?("3x")
      false
      iex>Unicode.math?("∑") # Summation, \u2211
      true
      iex>Unicode.math?("Σ") # Greek capital letter sigma, \u03a3
      false
  """
  @spec math?(String.codepoint | String.t) :: boolean
  def math?(codepoint_or_string)

  @spec alphabetic?(String.codepoint | String.t) :: boolean
  def alphabetic?(codepoint_or_string)
  
  @spec lowercase?(String.codepoint | String.t) :: boolean
  def lowercase?(codepoint_or_string)

  @spec uppercase?(String.codepoint | String.t) :: boolean
  def uppercase?(codepoint_or_string)



  # Define methods from the DerivedCoreProperties.txt
  File.stream!('unicode_source_files/DerivedCoreProperties.txt')
  |> Stream.reject(fn raw_line -> 
    # skip comments and empty lines.
    String.strip(raw_line) == "" || String.starts_with?(raw_line, "#")
  end)
  |> Stream.map(fn raw_line -> 
    [charinfo, property] = CompiletimeHelper.split_derived_core_properties_line(raw_line)

    # Only define functions for the properties that are part of @derived_core_properties
    snake_cased_property_name = Map.get(@derived_core_properties, String.to_atom(property))
    if snake_cased_property_name do
      method_name = String.to_atom("#{snake_cased_property_name}?")

      case String.split(charinfo, "..") do
        [low_code, high_code] ->
          low_code = String.to_integer(low_code, 16)
          high_code = String.to_integer(high_code, 16)
          def unquote(method_name)(code) when code in (unquote(low_code))..(unquote(high_code)), do: true
        [single_code] ->
          single_code = String.to_integer(single_code, 16)
          def unquote(method_name)(unquote(single_code)), do: true
      end
    end
  end)
  |> Stream.run

  for {_unicode_property, snake_cased_property_name} <- @derived_core_properties do
    method_name = String.to_atom("#{snake_cased_property_name}?")

    # Non-matching codepoints return `false`
    def unquote(method_name)(codepoint) when is_integer(codepoint), do: false
    
    # String handling: Match first codepoint and rest of codepoints.    
    def unquote(method_name)(string) when is_binary(string) do
      case String.next_codepoint(string) do
        nil -> false
        {<<codepoint::utf8>>, ""} ->  unquote(method_name)(codepoint)
        {<<codepoint::utf8>>, rest} -> unquote(method_name)(codepoint) && unquote(method_name)(rest)
      end
    end
  end

  # The regexp 'digit' group. Matches only the ASCII ?0 t/m ?9 characters.
  def numeric?(codepoint) when codepoint in ?0..?9, do: true
  def numeric?(codepoint) when is_integer(codepoint), do: false
  def numeric?(string) when is_binary(string) do
    case String.next_codepoint(string) do
      nil -> false
      {<<codepoint::utf8>>, ""} ->  numeric?(codepoint)
      {<<codepoint::utf8>>, rest} -> numeric?(codepoint) && numeric?(rest)
    end
  end

  # the regexp 'alnum' group.
  def alphanumeric?(codepoint) when is_integer(codepoint) do
    numeric?(codepoint) || alphabetic?(codepoint)
  end
  def alphanumeric?(string) when is_binary(string) do
    case String.next_codepoint(string) do
      nil -> false
      {<<codepoint::utf8>>, ""} ->  alphanumeric?(codepoint)
      {<<codepoint::utf8>>, rest} -> alphanumeric?(codepoint) && alphanumeric?(rest)
    end
  end

end