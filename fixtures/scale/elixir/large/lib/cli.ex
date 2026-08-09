defmodule Cryptobench.CLI do
  alias Cryptobench

  def run(_argv \\ []), do: Cryptobench.main()
end
