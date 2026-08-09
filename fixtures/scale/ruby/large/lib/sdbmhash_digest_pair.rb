require_relative 'sdbmhash_digest'

def sdbmhash_digest_pair(text)
  [sdbmhash_digest(text), text.length]
end
