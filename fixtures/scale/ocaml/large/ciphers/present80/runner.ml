open Model
open Impl
open Result

let run_case key pt =
  if decrypt key (encrypt key pt) = pt then pass cipher_name else fail cipher_name

let label = cipher_name ^ "/" ^ string_of_int key_bits
