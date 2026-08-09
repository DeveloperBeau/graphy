defmodule Printer.CLI do
  alias Printer

  def run(argv \\ []), do: Printer.main(argv)
end
