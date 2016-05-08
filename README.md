# Unicode

The _Unicode_ package provides functionality to check properties of unicode codepoints, graphemes and strings.

This is often useful when checking or validating the contents of strings in sitiations where using Regular Expressions is not necessary and/or too slow. 

The Unicode package is based on Version 8.0.0 of the Unicode standard.

Defined right now are:

- `Unicode.alphabetic?/1`
- `Unicode.numeric?/1`
- `Unicode.alphanumeric?/1`
- `Unicode.cased?/1`
- `Unicode.lowercase?/1`
- `Unicode.uppercase?/1`
- `Unicode.math?/1`


### Future Work

Right now, only a few functions implementing the Derived Core Properties are defined. To make this package more useful, functions implementing each of the [Unicode Regexp Compatibility Properties](http://www.unicode.org/reports/tr18/#Compatibility_Properties) should be added.



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed by adding unicode to your list of dependencies in `mix.exs`:

    def deps do
      [
        {:unicode, "~> 0.0.1"}
      ]
    end

You can now check properties of codepoints, graphemes or strings like follows:

    Unicode.alphabetic?(?á)
    Unicode.alphanumeric?("camembert123")
