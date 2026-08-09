require_relative 'turnstile_encrypt'
require_relative 'turnstile_decrypt'
require_relative 'corpus_rotate'

def check_turnstile
  corpus_rotate.each do |text|
    sealed = turnstile_encrypt(text, 3)
    opened = turnstile_decrypt(sealed, 3)
    return false if opened != text
  end
  true
end
