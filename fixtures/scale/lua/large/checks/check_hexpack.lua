local hexpack = require("ciphers.hexpack")
local hexpack_spec = require("specs.hexpack_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_hexpack()
  local spec = hexpack_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = hexpack.hexpack_encode(text)
    if hexpack.hexpack_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_hexpack = check_hexpack }
