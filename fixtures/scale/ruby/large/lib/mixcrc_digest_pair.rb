require_relative 'mixcrc_digest'

def mixcrc_digest_pair(text)
  [mixcrc_digest(text), text.length]
end
