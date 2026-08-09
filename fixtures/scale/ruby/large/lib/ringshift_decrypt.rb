require_relative 'ringshift_encrypt'

def ringshift_decrypt(text, key)
  n = ringshift_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
