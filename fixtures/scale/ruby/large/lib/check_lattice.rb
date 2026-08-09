require_relative 'lattice_encrypt'
require_relative 'lattice_decrypt'
require_relative 'corpus_rotate'

def check_lattice
  corpus_rotate.each do |text|
    sealed = lattice_encrypt(text, 6)
    opened = lattice_decrypt(sealed, 6)
    return false if opened != text
  end
  true
end
