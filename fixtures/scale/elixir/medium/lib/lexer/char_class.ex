defmodule Lexer.CharClass do
  def digit?(<<c>>), do: c >= ?0 and c <= ?9

  def alpha?(<<c>>), do: (c >= ?a and c <= ?z) or (c >= ?A and c <= ?Z)

  def space?(s), do: s == " " or s == "\t"
end
