def conveyor_offset(text, key)
  (key + 6) % [1, text.length].max
end

def conveyor_encrypt(text, key)
  n = conveyor_offset(text, key)
  text[n..] + text[0...n]
end
