local promoter = require("ciphers.promoter")
local promoter_spec = require("specs.promoter_spec")
local corpus_affine = require("corpus.corpus_affine")

local function check_promoter()
  local spec = promoter_spec.get()
  for _, text in ipairs(corpus_affine.corpus_affine()) do
    local sealed = promoter.promoter_encrypt(text, spec.key)
    local opened = promoter.promoter_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "affine"
end

return { check_promoter = check_promoter }
