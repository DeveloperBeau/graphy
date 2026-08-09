def blockrotate_offset(text, key)
  (key + 3) % [1, text.length].max
end

def blockrotate_encrypt(text, key)
  n = blockrotate_offset(text, key)
  text[n..] + text[0...n]
end
