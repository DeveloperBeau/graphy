local conveyor = require("ciphers.conveyor")
local conveyor_spec = require("specs.conveyor_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_conveyor()
  local spec = conveyor_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = conveyor.conveyor_encrypt(text, spec.key)
    local opened = conveyor.conveyor_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_conveyor = check_conveyor }
