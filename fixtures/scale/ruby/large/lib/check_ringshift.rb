require_relative 'ringshift_encrypt'
require_relative 'ringshift_decrypt'
require_relative 'corpus_rotate'

def check_ringshift
  corpus_rotate.each do |text|
    sealed = ringshift_encrypt(text, 17)
    opened = ringshift_decrypt(sealed, 17)
    return false if opened != text
  end
  true
end
