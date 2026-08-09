defmodule Render.Box do
  alias Model.Document
  alias Render.Line
  alias Style.Align

  def draw(style, w, doc) do
    head = [
      Line.rule(style, w),
      Line.framed(style, w, Align.align(:center, w, doc.title)),
      Line.rule(style, w)
    ]

    body = Enum.map(Document.rows(doc), &Line.framed(style, w, Align.align(:left, w, &1)))
    head ++ body ++ [Line.rule(style, w)]
  end
end
