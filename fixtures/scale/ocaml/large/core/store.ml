open Config

let save cfg results =
  let oc = open_out cfg.results_path in
  List.iter (fun r -> output_string oc (r ^ "\n")) results;
  close_out oc

let load cfg =
  if not (Sys.file_exists cfg.results_path) then []
  else begin
    let ic = open_in cfg.results_path in
    let rec go acc =
      match input_line ic with
      | line -> go (line :: acc)
      | exception End_of_file ->
        close_in ic;
        List.rev acc
    in
    go []
  end

let append cfg entry =
  let oc = open_out_gen [ Open_append; Open_creat ] 0o644 cfg.results_path in
  output_string oc (entry ^ "\n");
  close_out oc
