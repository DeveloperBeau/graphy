defmodule Support.Result do
  defstruct subject: "", passed: false

  def pass(name), do: %__MODULE__{subject: name, passed: true}

  def fail(name), do: %__MODULE__{subject: name, passed: false}

  def ok?(%__MODULE__{passed: p}), do: p
end
