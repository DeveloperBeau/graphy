require_relative 'blockrotate_encrypt'

def blockrotate_decrypt(text, key)
  n = blockrotate_offset(text, key)
  text[(text.length - n)..] + text[0...(text.length - n)]
end
