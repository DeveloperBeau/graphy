local linearmix = require("ciphers.linearmix")
local linearmix_spec = require("specs.linearmix_spec")
local corpus_affine = require("corpus.corpus_affine")

local function check_linearmix()
  local spec = linearmix_spec.get()
  for _, text in ipairs(corpus_affine.corpus_affine()) do
    local sealed = linearmix.linearmix_encrypt(text, spec.key)
    local opened = linearmix.linearmix_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "affine"
end

return { check_linearmix = check_linearmix }
