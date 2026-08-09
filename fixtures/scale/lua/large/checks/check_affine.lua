local affine = require("ciphers.affine")
local affine_spec = require("specs.affine_spec")
local corpus_affine = require("corpus.corpus_affine")

local function check_affine()
  local spec = affine_spec.get()
  for _, text in ipairs(corpus_affine.corpus_affine()) do
    local sealed = affine.affine_encrypt(text, spec.key)
    local opened = affine.affine_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "affine"
end

return { check_affine = check_affine }
