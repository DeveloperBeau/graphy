require_relative 'veilmask_encrypt'
require_relative 'veilmask_decrypt'
require_relative 'corpus_mask'

def check_veilmask
  corpus_mask.each do |text|
    sealed = veilmask_encrypt(text, 4)
    opened = veilmask_decrypt(sealed, 4)
    return false if opened != text
  end
  true
end
