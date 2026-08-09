local ferris = require("ciphers.ferris")
local ferris_spec = require("specs.ferris_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_ferris()
  local spec = ferris_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = ferris.ferris_encrypt(text, spec.key)
    local opened = ferris.ferris_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_ferris = check_ferris }
