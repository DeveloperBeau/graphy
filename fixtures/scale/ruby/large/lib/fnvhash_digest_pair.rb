require_relative 'fnvhash_digest'

def fnvhash_digest_pair(text)
  [fnvhash_digest(text), text.length]
end
