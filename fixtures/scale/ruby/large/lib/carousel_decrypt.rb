require_relative 'carousel_encrypt'

def carousel_decrypt(text, key)
  n = carousel_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
