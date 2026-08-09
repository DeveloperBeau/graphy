defmodule Printer do
  alias Input.Args
  alias Input.Reader
  alias Model.Document
  alias Output.Writer

  def main(argv \\ []) do
    opts = Args.parse(argv)
    body = Reader.read_lines("alpha\nbeta\ngamma")
    doc = Document.from_lines(opts.heading, body)
    Writer.emit(Writer.render(:bright, opts.box_width, doc))
  end
end
