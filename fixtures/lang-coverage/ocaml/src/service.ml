(* feature: open, module, let (top-level), call *)
open Types

let max_retries = 3

let make_service id name =
  { id; name }

let run_service svc =
  let msg = Helpers.format_name svc.name in
  print_endline msg;
  ignore (Helpers.unrelated_helper max_retries)

module ServiceRegistry = struct
  let table : (id, service) Hashtbl.t = Hashtbl.create 16

  let register svc = Hashtbl.replace table svc.id svc

  let lookup id = Hashtbl.find_opt table id
end
