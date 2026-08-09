open Prompt

let () =
  print_endline banner;
  let shown, _ = Loop.step Environment.empty "sqrt(16) + 2 * 3" [] in
  print_endline ("result = " ^ shown);
  print_endline ("functions: " ^ string_of_int (List.length Registry.names))
