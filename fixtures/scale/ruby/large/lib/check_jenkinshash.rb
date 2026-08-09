require_relative 'jenkinshash_digest'
require_relative 'jenkinshash_digest_pair'
require_relative 'corpus_hash'

def check_jenkinshash
  corpus_hash.each do |text|
    first = jenkinshash_digest(text)
    second = jenkinshash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
