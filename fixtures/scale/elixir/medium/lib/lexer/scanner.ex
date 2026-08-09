defmodule Lexer.Scanner do
  alias Lexer.Token

  def scan(line) do
    line
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.replace(",", " , ")
    |> String.split()
    |> Enum.map(&Token.classify/1)
  end
end
