open Cell

type document = { title : string; cells : cell list }

let from_lines title lines =
  { title; cells = List.map (fun l -> { content = l; pad = 2 }) lines }

let rows d = List.map text d.cells
