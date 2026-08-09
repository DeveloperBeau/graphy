require_relative 'lattice_encrypt'

def lattice_decrypt(text, key)
  n = lattice_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
