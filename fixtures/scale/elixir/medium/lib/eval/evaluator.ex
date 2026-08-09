defmodule Eval.Evaluator do
  alias Eval.Environment
  alias Functions.Registry

  def eval(_env, {:lit, n}), do: n
  def eval(env, {:var, name}), do: Environment.lookup_var(env, name)

  def eval(env, {:call, fun, args}) do
    Registry.dispatch(fun, Enum.map(args, &eval(env, &1)))
  end

  def eval(env, {:binop, op, a, b}), do: apply_op(op, eval(env, a), eval(env, b))

  defp apply_op("+", a, b), do: a + b
  defp apply_op("-", a, b), do: a - b
  defp apply_op("*", a, b), do: a * b
  defp apply_op("^", a, b), do: :math.pow(a, b)
  defp apply_op(_, a, b), do: if(b == 0, do: 0.0, else: a / b)
end
