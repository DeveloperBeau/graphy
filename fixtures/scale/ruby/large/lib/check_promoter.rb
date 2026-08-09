require_relative 'promoter_encrypt'
require_relative 'promoter_decrypt'
require_relative 'corpus_affine'

def check_promoter
  corpus_affine.each do |text|
    sealed = promoter_encrypt(text, 13)
    opened = promoter_decrypt(sealed, 13)
    return false if opened != text
  end
  true
end
