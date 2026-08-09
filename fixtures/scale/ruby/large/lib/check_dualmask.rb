require_relative 'dualmask_encrypt'
require_relative 'dualmask_decrypt'
require_relative 'corpus_mask'

def check_dualmask
  corpus_mask.each do |text|
    sealed = dualmask_encrypt(text, 5)
    opened = dualmask_decrypt(sealed, 5)
    return false if opened != text
  end
  true
end
