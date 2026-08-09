defmodule Core.Config do
  defstruct iterations: 100, results_path: "results.log", verbose: true

  def defaults, do: %__MODULE__{}
end
