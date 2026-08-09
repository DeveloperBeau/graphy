require_relative 'conveyor_encrypt'
require_relative 'conveyor_decrypt'
require_relative 'corpus_rotate'

def check_conveyor
  corpus_rotate.each do |text|
    sealed = conveyor_encrypt(text, 19)
    opened = conveyor_decrypt(sealed, 19)
    return false if opened != text
  end
  true
end
