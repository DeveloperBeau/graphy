open Align

let draw b w doc =
  [ Line.rule b w
  ; Line.framed b w (apply Center_a w doc.Document.title)
  ; Line.rule b w
  ]
  @ List.map (fun r -> Line.framed b w (apply Left_a w r)) (Document.rows doc)
  @ [ Line.rule b w ]
