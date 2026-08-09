local chainhash = require("ciphers.chainhash")
local chainhash_spec = require("specs.chainhash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_chainhash()
  local spec = chainhash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = chainhash.chainhash_digest(text)
    local second = chainhash.chainhash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_chainhash = check_chainhash }
