def ferris_offset(text, key)
  (key + 2) % [1, text.length].max
end

def ferris_encrypt(text, key)
  n = ferris_offset(text, key)
  text[n..] + text[0...n]
end
