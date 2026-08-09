let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

let encode block =
  String.concat "" (List.map (fun b -> String.make 1 alphabet.[b mod 64]) block)
