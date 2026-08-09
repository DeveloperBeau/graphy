local stairstep = require("ciphers.stairstep")
local stairstep_spec = require("specs.stairstep_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_stairstep()
  local spec = stairstep_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = stairstep.stairstep_encrypt(text, spec.key)
    local opened = stairstep.stairstep_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_stairstep = check_stairstep }
