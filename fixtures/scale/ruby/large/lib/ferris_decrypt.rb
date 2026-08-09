require_relative 'ferris_encrypt'

def ferris_decrypt(text, key)
  n = ferris_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
