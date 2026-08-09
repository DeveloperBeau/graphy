def ringshift_offset(text, key)
  (key + 4) % [1, text.length].max
end

def ringshift_encrypt(text, key)
  n = ringshift_offset(text, key)
  text[n..] + text[0...n]
end
