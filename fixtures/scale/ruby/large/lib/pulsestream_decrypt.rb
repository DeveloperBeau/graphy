require_relative 'pulsestream_encrypt'

def pulsestream_decrypt(text, key)
  pulsestream_encrypt(text, key)
end
