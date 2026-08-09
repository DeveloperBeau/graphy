require_relative 'paritymix_encrypt'
require_relative 'paritymix_decrypt'
require_relative 'corpus_mask'

def check_paritymix
  corpus_mask.each do |text|
    sealed = paritymix_encrypt(text, 19)
    opened = paritymix_decrypt(sealed, 19)
    return false if opened != text
  end
  true
end
