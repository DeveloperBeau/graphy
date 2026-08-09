open Model

let encrypt key block =
  List.map (fun b -> (b + key + rounds + key_bits) mod 256) block

let decrypt key block =
  List.map (fun b -> (b - key - rounds - key_bits + 512) mod 256) block
