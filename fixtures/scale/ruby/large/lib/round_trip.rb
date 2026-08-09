require_relative 'get_cipher'
require_relative 'fingerprint'
require_relative 'now_ms'
require_relative 'elapsed'

def round_trip(name, text, key)
  encrypt, decrypt = get_cipher(name)
  start = now_ms
  sealed = encrypt.call(text, key)
  opened = decrypt.call(sealed, key)
  { name: name, ok: opened == text, fp: fingerprint(sealed), ms: elapsed(start) }
end
