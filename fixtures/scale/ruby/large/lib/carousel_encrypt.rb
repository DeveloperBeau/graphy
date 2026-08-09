def carousel_offset(text, key)
  (key + 5) % [1, text.length].max
end

def carousel_encrypt(text, key)
  n = carousel_offset(text, key)
  text[n..] + text[0...n]
end
