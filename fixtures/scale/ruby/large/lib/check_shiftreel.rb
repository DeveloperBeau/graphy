require_relative 'shiftreel_encrypt'
require_relative 'shiftreel_decrypt'
require_relative 'corpus_additive'

def check_shiftreel
  corpus_additive.each do |text|
    sealed = shiftreel_encrypt(text, 6)
    opened = shiftreel_decrypt(sealed, 6)
    return false if opened != text
  end
  true
end
