require_relative 'turnstile_encrypt'

def turnstile_decrypt(text, key)
  n = turnstile_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
