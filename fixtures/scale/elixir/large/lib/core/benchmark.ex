defmodule Core.Benchmark do
  alias Support.Result
  alias Support.Timer

  defstruct name: "", elapsed: 0, green: 0

  def run(name, results) do
    started = Timer.start()
    green = Enum.count(results, &Result.ok?/1)
    %__MODULE__{name: name, elapsed: Timer.measure(started), green: green}
  end
end
