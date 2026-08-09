open Border

let rule b w = String.make w (horizontal b)

let framed b w s =
  String.make 1 (vertical b) ^ Pad.pad_to w s ^ String.make 1 (vertical b)
