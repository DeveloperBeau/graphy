defmodule Repl.Loop do
  alias Eval.Evaluator
  alias History.Log
  alias Lexer.Scanner
  alias Parser.Parser

  def eval_line(env, line) do
    Evaluator.eval(env, Parser.parse(Scanner.scan(line)))
  end

  def step(env, line, log) do
    value = eval_line(env, line)
    {value, Log.record(log, line, value)}
  end
end
