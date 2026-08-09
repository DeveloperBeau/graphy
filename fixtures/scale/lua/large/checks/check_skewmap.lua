local skewmap = require("ciphers.skewmap")
local skewmap_spec = require("specs.skewmap_spec")
local corpus_affine = require("corpus.corpus_affine")

local function check_skewmap()
  local spec = skewmap_spec.get()
  for _, text in ipairs(corpus_affine.corpus_affine()) do
    local sealed = skewmap.skewmap_encrypt(text, spec.key)
    local opened = skewmap.skewmap_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "affine"
end

return { check_skewmap = check_skewmap }
