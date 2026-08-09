require_relative 'augustus_encrypt'
require_relative 'augustus_decrypt'
require_relative 'corpus_additive'

def check_augustus
  corpus_additive.each do |text|
    sealed = augustus_encrypt(text, 8)
    opened = augustus_decrypt(sealed, 8)
    return false if opened != text
  end
  true
end
