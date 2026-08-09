local ordinal = require("ciphers.ordinal")
local ordinal_spec = require("specs.ordinal_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_ordinal()
  local spec = ordinal_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = ordinal.ordinal_encrypt(text, spec.key)
    local opened = ordinal.ordinal_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_ordinal = check_ordinal }
