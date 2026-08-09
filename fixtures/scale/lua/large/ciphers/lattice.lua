local function lattice_offset(text, key)
  return (key + 3) % math.max(1, #text)
end

local function lattice_encrypt(text, key)
  local n = lattice_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function lattice_decrypt(text, key)
  local n = lattice_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { lattice_offset = lattice_offset, lattice_encrypt = lattice_encrypt, lattice_decrypt = lattice_decrypt }
