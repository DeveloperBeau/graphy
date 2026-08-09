local gronsfeld = require("ciphers.gronsfeld")
local gronsfeld_spec = require("specs.gronsfeld_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_gronsfeld()
  local spec = gronsfeld_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = gronsfeld.gronsfeld_encrypt(text, spec.key)
    local opened = gronsfeld.gronsfeld_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_gronsfeld = check_gronsfeld }
