require_relative 'keypad_encrypt'
require_relative 'keypad_decrypt'
require_relative 'corpus_additive'

def check_keypad
  corpus_additive.each do |text|
    sealed = keypad_encrypt(text, 9)
    opened = keypad_decrypt(sealed, 9)
    return false if opened != text
  end
  true
end
