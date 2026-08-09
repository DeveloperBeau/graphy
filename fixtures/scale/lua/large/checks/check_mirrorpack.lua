local mirrorpack = require("ciphers.mirrorpack")
local mirrorpack_spec = require("specs.mirrorpack_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_mirrorpack()
  local spec = mirrorpack_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = mirrorpack.mirrorpack_encode(text)
    if mirrorpack.mirrorpack_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_mirrorpack = check_mirrorpack }
