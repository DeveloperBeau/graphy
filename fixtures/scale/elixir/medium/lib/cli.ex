defmodule Calc.CLI do
  alias Calc

  def main(args \\ []) do
    line = Enum.join(args, " ")
    input = if line == "", do: "sqrt(16) + 2 * 3", else: line
    Calc.run(input)
    :ok
  end
end
