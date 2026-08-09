local turnstile = require("ciphers.turnstile")
local turnstile_spec = require("specs.turnstile_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_turnstile()
  local spec = turnstile_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = turnstile.turnstile_encrypt(text, spec.key)
    local opened = turnstile.turnstile_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_turnstile = check_turnstile }
