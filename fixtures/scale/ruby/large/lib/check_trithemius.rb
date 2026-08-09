require_relative 'trithemius_encrypt'
require_relative 'trithemius_decrypt'
require_relative 'corpus_additive'

def check_trithemius
  corpus_additive.each do |text|
    sealed = trithemius_encrypt(text, 5)
    opened = trithemius_decrypt(sealed, 5)
    return false if opened != text
  end
  true
end
