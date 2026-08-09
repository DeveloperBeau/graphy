local augustus = require("ciphers.augustus")
local augustus_spec = require("specs.augustus_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_augustus()
  local spec = augustus_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = augustus.augustus_encrypt(text, spec.key)
    local opened = augustus.augustus_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_augustus = check_augustus }
