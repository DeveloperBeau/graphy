require_relative 'maskbyte_encrypt'
require_relative 'maskbyte_decrypt'
require_relative 'corpus_mask'

def check_maskbyte
  corpus_mask.each do |text|
    sealed = maskbyte_encrypt(text, 18)
    opened = maskbyte_decrypt(sealed, 18)
    return false if opened != text
  end
  true
end
