require_relative 'linearmix_encrypt'
require_relative 'linearmix_decrypt'
require_relative 'corpus_affine'

def check_linearmix
  corpus_affine.each do |text|
    sealed = linearmix_encrypt(text, 15)
    opened = linearmix_decrypt(sealed, 15)
    return false if opened != text
  end
  true
end
