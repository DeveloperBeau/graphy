def lattice_offset(text, key)
  (key + 3) % [1, text.length].max
end

def lattice_encrypt(text, key)
  n = lattice_offset(text, key)
  text[n..] + text[0...n]
end
