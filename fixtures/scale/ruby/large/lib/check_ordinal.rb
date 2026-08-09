require_relative 'ordinal_encrypt'
require_relative 'ordinal_decrypt'
require_relative 'corpus_additive'

def check_ordinal
  corpus_additive.each do |text|
    sealed = ordinal_encrypt(text, 10)
    opened = ordinal_decrypt(sealed, 10)
    return false if opened != text
  end
  true
end
