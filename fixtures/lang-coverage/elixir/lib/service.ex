defmodule Service do
  # feature: defmodule, alias, import, require, use, def, call
  alias Helpers
  import String, only: [upcase: 1]
  require Logger

  def run(name) do
    greeting = Helpers.format_name(name)
    greeting
  end

  def describe(name) do
    "Service(#{name})"
  end

  defp private_run(name) do
    run(name)
  end
end
