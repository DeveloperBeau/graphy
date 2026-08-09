require_relative 'windmill_encrypt'

def windmill_decrypt(text, key)
  n = windmill_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
