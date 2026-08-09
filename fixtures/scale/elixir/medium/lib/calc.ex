defmodule Calc do
  alias Eval.Environment
  alias History.Log
  alias Io.Console
  alias Repl.Loop

  def run(line) do
    {value, log} = Loop.step(Environment.empty(), line, %Log{})
    Console.print_result(line, value)
    log
  end
end
