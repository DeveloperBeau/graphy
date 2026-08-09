let digits = "0123456789abcdef"

let encode block =
  String.concat ""
    (List.map (fun b -> Printf.sprintf "%c%c" digits.[b / 16] digits.[b mod 16]) block)

let decode s =
  let value c = String.index digits c in
  let rec go i acc =
    if i + 1 >= String.length s then List.rev acc
    else go (i + 2) (((value s.[i] * 16) + value s.[i + 1]) :: acc)
  in
  go 0 []
