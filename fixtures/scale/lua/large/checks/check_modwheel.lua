local modwheel = require("ciphers.modwheel")
local modwheel_spec = require("specs.modwheel_spec")
local corpus_affine = require("corpus.corpus_affine")

local function check_modwheel()
  local spec = modwheel_spec.get()
  for _, text in ipairs(corpus_affine.corpus_affine()) do
    local sealed = modwheel.modwheel_encrypt(text, spec.key)
    local opened = modwheel.modwheel_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "affine"
end

return { check_modwheel = check_modwheel }
