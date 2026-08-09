local pairswap = require("ciphers.pairswap")
local pairswap_spec = require("specs.pairswap_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_pairswap()
  local spec = pairswap_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = pairswap.pairswap_encode(text)
    if pairswap.pairswap_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_pairswap = check_pairswap }
