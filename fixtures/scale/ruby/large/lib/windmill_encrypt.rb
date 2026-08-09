def windmill_offset(text, key)
  (key + 1) % [1, text.length].max
end

def windmill_encrypt(text, key)
  n = windmill_offset(text, key)
  text[n..] + text[0...n]
end
