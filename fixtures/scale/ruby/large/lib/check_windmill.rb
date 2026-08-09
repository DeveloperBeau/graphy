require_relative 'windmill_encrypt'
require_relative 'windmill_decrypt'
require_relative 'corpus_rotate'

def check_windmill
  corpus_rotate.each do |text|
    sealed = windmill_encrypt(text, 4)
    opened = windmill_decrypt(sealed, 4)
    return false if opened != text
  end
  true
end
