require_relative 'caesar_encrypt'
require_relative 'caesar_decrypt'
require_relative 'corpus_additive'

def check_caesar
  corpus_additive.each do |text|
    sealed = caesar_encrypt(text, 3)
    opened = caesar_decrypt(sealed, 3)
    return false if opened != text
  end
  true
end
