defmodule Types do
  # feature: defmodule, def, defp, defstruct
  defstruct [:name, :active]

  @max_retries 3

  def max_retries, do: @max_retries

  defp internal_name, do: "graphy-elixir-fixture"

  def service_name, do: internal_name()
end
