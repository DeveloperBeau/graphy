require_relative 'skewmap_encrypt'
require_relative 'skewmap_decrypt'
require_relative 'corpus_affine'

def check_skewmap
  corpus_affine.each do |text|
    sealed = skewmap_encrypt(text, 16)
    opened = skewmap_decrypt(sealed, 16)
    return false if opened != text
  end
  true
end
