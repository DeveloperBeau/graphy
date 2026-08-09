local sdbmhash = require("ciphers.sdbmhash")
local sdbmhash_spec = require("specs.sdbmhash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_sdbmhash()
  local spec = sdbmhash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = sdbmhash.sdbmhash_digest(text)
    local second = sdbmhash.sdbmhash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_sdbmhash = check_sdbmhash }
