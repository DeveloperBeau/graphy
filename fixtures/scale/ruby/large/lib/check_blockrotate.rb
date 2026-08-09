require_relative 'blockrotate_encrypt'
require_relative 'blockrotate_decrypt'
require_relative 'corpus_rotate'

def check_blockrotate
  corpus_rotate.each do |text|
    sealed = blockrotate_encrypt(text, 16)
    opened = blockrotate_decrypt(sealed, 16)
    return false if opened != text
  end
  true
end
