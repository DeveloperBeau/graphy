require_relative 'affine_encrypt'
require_relative 'affine_decrypt'
require_relative 'corpus_affine'

def check_affine
  corpus_affine.each do |text|
    sealed = affine_encrypt(text, 11)
    opened = affine_decrypt(sealed, 11)
    return false if opened != text
  end
  true
end
