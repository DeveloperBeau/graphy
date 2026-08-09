open Config

let () =
  let opts = Args.parse Sys.argv in
  let previous = Store.load defaults in
  print_endline (string_of_int (List.length previous) ^ " prior results");
  print_endline (Progress.render 1 Registry.size);
  print_endline (string_of_int (List.length Registry.catalog) ^ " ciphers registered");
  Store.save defaults [ "warmup" ];
  ignore opts.quick
