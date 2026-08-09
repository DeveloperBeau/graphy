def turnstile_offset(text, key)
  (key + 7) % [1, text.length].max
end

def turnstile_encrypt(text, key)
  n = turnstile_offset(text, key)
  text[n..] + text[0...n]
end
