let next seed =
  let s = ((seed * 1103515245) + 12345) mod 2147483647 in
  (s mod 256, s)

let rec stream n seed =
  if n = 0 then []
  else
    let b, s = next seed in
    b :: stream (n - 1) s
