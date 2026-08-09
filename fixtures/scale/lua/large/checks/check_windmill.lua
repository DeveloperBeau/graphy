local windmill = require("ciphers.windmill")
local windmill_spec = require("specs.windmill_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_windmill()
  local spec = windmill_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = windmill.windmill_encrypt(text, spec.key)
    local opened = windmill.windmill_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_windmill = check_windmill }
