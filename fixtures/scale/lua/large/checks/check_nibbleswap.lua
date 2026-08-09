local nibbleswap = require("ciphers.nibbleswap")
local nibbleswap_spec = require("specs.nibbleswap_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_nibbleswap()
  local spec = nibbleswap_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = nibbleswap.nibbleswap_encode(text)
    if nibbleswap.nibbleswap_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_nibbleswap = check_nibbleswap }
