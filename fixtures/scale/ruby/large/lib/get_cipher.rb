require_relative 'caesar_encrypt'
require_relative 'caesar_decrypt'
require_relative 'xorkey_encrypt'
require_relative 'xorkey_decrypt'

def get_cipher(name)
  table = {
    "caesar" => [method(:caesar_encrypt), method(:caesar_decrypt)],
    "xorkey" => [method(:xorkey_encrypt), method(:xorkey_decrypt)],
  }
  raise "unknown cipher: #{name}" unless table.key?(name)
  table[name]
end
