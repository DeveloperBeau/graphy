type options = { only_cipher : string option; quick : bool }

let parse argv =
  let quick = Array.exists (fun a -> a = "--quick") argv in
  let only = if Array.length argv > 1 then Some argv.(1) else None in
  { only_cipher = only; quick }
