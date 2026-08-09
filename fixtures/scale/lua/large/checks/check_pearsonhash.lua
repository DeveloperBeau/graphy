local pearsonhash = require("ciphers.pearsonhash")
local pearsonhash_spec = require("specs.pearsonhash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_pearsonhash()
  local spec = pearsonhash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = pearsonhash.pearsonhash_digest(text)
    local second = pearsonhash.pearsonhash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_pearsonhash = check_pearsonhash }
