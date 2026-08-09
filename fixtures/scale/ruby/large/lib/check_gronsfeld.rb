require_relative 'gronsfeld_encrypt'
require_relative 'gronsfeld_decrypt'
require_relative 'corpus_additive'

def check_gronsfeld
  corpus_additive.each do |text|
    sealed = gronsfeld_encrypt(text, 4)
    opened = gronsfeld_decrypt(sealed, 4)
    return false if opened != text
  end
  true
end
