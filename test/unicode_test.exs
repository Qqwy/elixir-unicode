defmodule UnicodeTest do
  use ExUnit.Case
  doctest Unicode

  test "block ranges" do
    assert Unicode.alphabetic?("html", "Basic Latin") == true # ascii only
    assert Unicode.alphabetic?("div", "basiclatin") == true
    assert Unicode.alphabetic?("Σ", "Greek and Coptic") == true
    assert Unicode.alphabetic?("Elixir", "Greek and Coptic") == false
    assert Unicode.alphabetic?("Σ", ["Greek and Coptic"]) == true
    assert Unicode.alphabetic?("Σ", ["Greek and Coptic", "Basic Latin"]) == true
    assert Unicode.alphabetic?("Σlixir", ["Greek and Coptic", "Basic Latin"]) == true
    assert Unicode.alphabetic?("Elixir", ["Greek and Coptic", "Basic Latin"]) == true
    assert Unicode.alphabetic?("Elixir+", ["Greek and Coptic", "Basic Latin"]) == false

    assert Unicode.alphanumeric?("1234", ["Greek and Coptic", "Basic Latin"]) == true
    assert Unicode.alphanumeric?("ΣSUM1234", ["Greek and Coptic", "Basic Latin"]) == true
    assert Unicode.alphanumeric?("Σ1234", "Greek and Coptic") == true
    assert Unicode.alphanumeric?("ΣSUM+1234", ["Greek and Coptic", "Basic Latin"]) == false

    assert Unicode.alphanumeric?("abc123", "Does not Exist") == false # should raise error?

    assert Unicode.math?("+", "Basic Latin") == true
    assert Unicode.math?("+", "Mathematical Operators") == false
    assert Unicode.math?("+", ["Mathematical Operators", "basic latin"]) == true
    assert Unicode.math?("∑") == true # summation
    assert Unicode.math?("Σ", "Greek and Coptic") == false # Greek capital letter sigma
    assert Unicode.math?("Σ", "Mathematical Operators") == false # Greek capital letter sigma
    assert Unicode.math?("∑", "Mathematical Operators") == true # summation
    assert Unicode.math?("+∑=", ["Mathematical Operators", "basic latin"]) == true
  end
end
