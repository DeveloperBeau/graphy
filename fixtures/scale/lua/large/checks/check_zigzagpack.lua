local zigzagpack = require("ciphers.zigzagpack")
local zigzagpack_spec = require("specs.zigzagpack_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_zigzagpack()
  local spec = zigzagpack_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = zigzagpack.zigzagpack_encode(text)
    if zigzagpack.zigzagpack_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_zigzagpack = check_zigzagpack }
