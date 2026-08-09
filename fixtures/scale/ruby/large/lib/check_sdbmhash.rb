require_relative 'sdbmhash_digest'
require_relative 'sdbmhash_digest_pair'
require_relative 'corpus_hash'

def check_sdbmhash
  corpus_hash.each do |text|
    first = sdbmhash_digest(text)
    second = sdbmhash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
