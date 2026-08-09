require_relative 'carousel_encrypt'
require_relative 'carousel_decrypt'
require_relative 'corpus_rotate'

def check_carousel
  corpus_rotate.each do |text|
    sealed = carousel_encrypt(text, 18)
    opened = carousel_decrypt(sealed, 18)
    return false if opened != text
  end
  true
end
