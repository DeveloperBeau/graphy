local lattice = require("ciphers.lattice")
local lattice_spec = require("specs.lattice_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_lattice()
  local spec = lattice_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = lattice.lattice_encrypt(text, spec.key)
    local opened = lattice.lattice_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_lattice = check_lattice }
