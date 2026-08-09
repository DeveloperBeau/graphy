require_relative 'conveyor_encrypt'

def conveyor_decrypt(text, key)
  n = conveyor_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
