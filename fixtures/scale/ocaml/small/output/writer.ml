open Border
open Palette

let render pal w doc = List.map (pick pal) (Box.draw Rounded w doc)

let emit lines = List.iter print_endline lines
