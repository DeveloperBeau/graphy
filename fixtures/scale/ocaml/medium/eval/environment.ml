let empty = []

let bind key value env = (key, value) :: env

let lookup_var env key =
  match List.assoc_opt key env with
  | Some v -> v
  | None -> ( match Constants.constant key with Some v -> v | None -> 0. )
