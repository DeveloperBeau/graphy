defmodule Core.Progress do
  alias Support.Format

  def render(done, total) do
    Format.bar(div(done * 20, max(total, 1))) <> Format.pad_left(6, Integer.to_string(done))
  end

  def emit(done, total), do: IO.write("\r" <> render(done, total))
end
