let zeros n = List.init n (fun _ -> 0)

let add_all k block = List.map (fun b -> (b + k) mod 256) block

let rotate n block =
  let rec drop i = function
    | rest when i = 0 -> rest
    | _ :: rest -> drop (i - 1) rest
    | [] -> []
  in
  drop n block @ List.filteri (fun i _ -> i < n) block
