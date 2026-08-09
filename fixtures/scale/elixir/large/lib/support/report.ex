defmodule Support.Report do
  alias Support.Format
  alias Support.Result

  def line(r) do
    Format.pad_right(20, r.subject) <> if(r.passed, do: "PASS", else: "FAIL")
  end

  def summary(results) do
    green = Enum.count(results, &Result.ok?/1)
    Integer.to_string(green) <> "/" <> Integer.to_string(length(results)) <> " passed"
  end
end
