open Log

let format_number n = Printf.sprintf "%.3f" n

let format_entry e = e.source ^ " = " ^ format_number e.outcome
