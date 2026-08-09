local shiftreel = require("ciphers.shiftreel")
local shiftreel_spec = require("specs.shiftreel_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_shiftreel()
  local spec = shiftreel_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = shiftreel.shiftreel_encrypt(text, spec.key)
    local opened = shiftreel.shiftreel_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_shiftreel = check_shiftreel }
