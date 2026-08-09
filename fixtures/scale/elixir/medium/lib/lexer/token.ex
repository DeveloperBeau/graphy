defmodule Lexer.Token do
  alias Lexer.CharClass

  def classify("("), do: :lparen
  def classify(")"), do: :rparen
  def classify(","), do: :comma

  def classify(word) do
    cond do
      CharClass.digit?(String.first(word)) ->
        {n, _} = Integer.parse(word)
        {:num, n * 1.0}

      CharClass.alpha?(String.first(word)) ->
        {:ident, word}

      true ->
        {:op, word}
    end
  end
end
