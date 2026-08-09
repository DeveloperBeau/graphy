require_relative 'weavehash_digest'

def weavehash_digest_pair(text)
  [weavehash_digest(text), text.length]
end
