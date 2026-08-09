local blockrotate = require("ciphers.blockrotate")
local blockrotate_spec = require("specs.blockrotate_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_blockrotate()
  local spec = blockrotate_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = blockrotate.blockrotate_encrypt(text, spec.key)
    local opened = blockrotate.blockrotate_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_blockrotate = check_blockrotate }
