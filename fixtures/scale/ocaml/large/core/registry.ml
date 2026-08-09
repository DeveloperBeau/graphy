let catalog = [ "aes-128"; "chacha20-256"; "salsa20-256"; "blowfish-256" ]

let size = List.length catalog

let member name = List.mem name catalog
