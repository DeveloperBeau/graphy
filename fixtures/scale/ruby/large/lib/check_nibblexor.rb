require_relative 'nibblexor_encrypt'
require_relative 'nibblexor_decrypt'
require_relative 'corpus_mask'

def check_nibblexor
  corpus_mask.each do |text|
    sealed = nibblexor_encrypt(text, 6)
    opened = nibblexor_decrypt(sealed, 6)
    return false if opened != text
  end
  true
end
