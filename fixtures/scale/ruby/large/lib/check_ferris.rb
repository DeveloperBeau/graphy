require_relative 'ferris_encrypt'
require_relative 'ferris_decrypt'
require_relative 'corpus_rotate'

def check_ferris
  corpus_rotate.each do |text|
    sealed = ferris_encrypt(text, 5)
    opened = ferris_decrypt(sealed, 5)
    return false if opened != text
  end
  true
end
