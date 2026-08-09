require_relative 'fnvhash_digest'
require_relative 'fnvhash_digest_pair'
require_relative 'corpus_hash'

def check_fnvhash
  corpus_hash.each do |text|
    first = fnvhash_digest(text)
    second = fnvhash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
