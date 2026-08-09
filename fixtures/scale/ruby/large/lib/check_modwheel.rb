require_relative 'modwheel_encrypt'
require_relative 'modwheel_decrypt'
require_relative 'corpus_affine'

def check_modwheel
  corpus_affine.each do |text|
    sealed = modwheel_encrypt(text, 14)
    opened = modwheel_decrypt(sealed, 14)
    return false if opened != text
  end
  true
end
