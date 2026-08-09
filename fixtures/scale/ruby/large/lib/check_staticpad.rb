require_relative 'staticpad_encrypt'
require_relative 'staticpad_decrypt'
require_relative 'corpus_mask'

def check_staticpad
  corpus_mask.each do |text|
    sealed = staticpad_encrypt(text, 7)
    opened = staticpad_decrypt(sealed, 7)
    return false if opened != text
  end
  true
end
