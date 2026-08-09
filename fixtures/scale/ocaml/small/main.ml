open Args
open Palette

let () =
  let argv = Array.to_list Sys.argv in
  let opts = parse (match argv with _ :: rest -> rest | [] -> []) in
  let body = Reader.read_lines "alpha\nbeta\ngamma" in
  let doc = Document.from_lines opts.heading body in
  Writer.emit (Writer.render Bright opts.box_width doc)
