require_relative 'xorkey_encrypt'
require_relative 'xorkey_decrypt'
require_relative 'corpus_mask'

def check_xorkey
  corpus_mask.each do |text|
    sealed = xorkey_encrypt(text, 17)
    opened = xorkey_decrypt(sealed, 17)
    return false if opened != text
  end
  true
end
