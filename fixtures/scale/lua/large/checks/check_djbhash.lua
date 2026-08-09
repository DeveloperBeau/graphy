local djbhash = require("ciphers.djbhash")
local djbhash_spec = require("specs.djbhash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_djbhash()
  local spec = djbhash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = djbhash.djbhash_digest(text)
    local second = djbhash.djbhash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_djbhash = check_djbhash }
