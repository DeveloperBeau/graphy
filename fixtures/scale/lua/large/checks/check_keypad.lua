local keypad = require("ciphers.keypad")
local keypad_spec = require("specs.keypad_spec")
local corpus_additive = require("corpus.corpus_additive")

local function check_keypad()
  local spec = keypad_spec.get()
  for _, text in ipairs(corpus_additive.corpus_additive()) do
    local sealed = keypad.keypad_encrypt(text, spec.key)
    local opened = keypad.keypad_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "additive"
end

return { check_keypad = check_keypad }
