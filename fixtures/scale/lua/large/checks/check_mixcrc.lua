local mixcrc = require("ciphers.mixcrc")
local mixcrc_spec = require("specs.mixcrc_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_mixcrc()
  local spec = mixcrc_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = mixcrc.mixcrc_digest(text)
    local second = mixcrc.mixcrc_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_mixcrc = check_mixcrc }
