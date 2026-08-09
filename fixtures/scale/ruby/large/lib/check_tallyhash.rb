require_relative 'tallyhash_digest'
require_relative 'tallyhash_digest_pair'
require_relative 'corpus_hash'

def check_tallyhash
  corpus_hash.each do |text|
    first = tallyhash_digest(text)
    second = tallyhash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
