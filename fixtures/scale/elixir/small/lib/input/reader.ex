defmodule Input.Reader do
  def read_lines(text) do
    text |> String.split("\n") |> Enum.reject(&(&1 == ""))
  end

  def clean(text), do: String.replace(text, "\r", "")
end
