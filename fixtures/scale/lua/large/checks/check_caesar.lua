local caesar = require("ciphers.caesar")
local caesar_spec = require("specs.caesar_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_caesar()
  local spec = caesar_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = caesar.caesar_encrypt(text, spec.key)
    local opened = caesar.caesar_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_caesar = check_caesar }
