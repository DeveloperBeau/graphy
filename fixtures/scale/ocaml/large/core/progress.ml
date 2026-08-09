let render done_n total =
  Fmt.bar (done_n * 20 / max 1 total) ^ Fmt.pad_left 6 (string_of_int done_n)

let tick n = n + 1
