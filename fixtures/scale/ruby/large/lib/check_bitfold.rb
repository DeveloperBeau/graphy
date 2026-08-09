require_relative 'bitfold_encrypt'
require_relative 'bitfold_decrypt'
require_relative 'corpus_mask'

def check_bitfold
  corpus_mask.each do |text|
    sealed = bitfold_encrypt(text, 3)
    opened = bitfold_decrypt(sealed, 3)
    return false if opened != text
  end
  true
end
