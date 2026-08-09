require_relative 'stairstep_encrypt'
require_relative 'stairstep_decrypt'
require_relative 'corpus_additive'

def check_stairstep
  corpus_additive.each do |text|
    sealed = stairstep_encrypt(text, 7)
    opened = stairstep_decrypt(sealed, 7)
    return false if opened != text
  end
  true
end
