type options = { box_width : int; heading : string }

let parse = function
  | w :: rest ->
    let width = try int_of_string w with Failure _ -> 32 in
    { box_width = width; heading = String.concat " " rest }
  | [] -> { box_width = 32; heading = "report" }
