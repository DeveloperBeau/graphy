open Timer
open Result

type bench = { bench_name : string; elapsed : int; green : int }

let run name start finish rs =
  { bench_name = name
  ; elapsed = measure start finish
  ; green = List.length (List.filter ok rs)
  }
