local trithemius = require("ciphers.trithemius")
local trithemius_spec = require("specs.trithemius_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_trithemius()
  local spec = trithemius_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = trithemius.trithemius_encrypt(text, spec.key)
    local opened = trithemius.trithemius_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_trithemius = check_trithemius }
