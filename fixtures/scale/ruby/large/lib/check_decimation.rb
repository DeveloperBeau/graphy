require_relative 'decimation_encrypt'
require_relative 'decimation_decrypt'
require_relative 'corpus_affine'

def check_decimation
  corpus_affine.each do |text|
    sealed = decimation_encrypt(text, 12)
    opened = decimation_decrypt(sealed, 12)
    return false if opened != text
  end
  true
end
