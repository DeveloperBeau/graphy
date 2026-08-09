require_relative 'jenkinshash_digest'

def jenkinshash_digest_pair(text)
  [jenkinshash_digest(text), text.length]
end
