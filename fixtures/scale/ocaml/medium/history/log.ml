type entry = { source : string; outcome : float }

let record src value entries = { source = src; outcome = value } :: entries

let recent n entries = List.filteri (fun i _ -> i < n) entries
