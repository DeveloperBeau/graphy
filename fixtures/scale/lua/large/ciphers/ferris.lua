local function ferris_offset(text, key)
  return (key + 2) % math.max(1, #text)
end

local function ferris_encrypt(text, key)
  local n = ferris_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function ferris_decrypt(text, key)
  local n = ferris_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { ferris_offset = ferris_offset, ferris_encrypt = ferris_encrypt, ferris_decrypt = ferris_decrypt }
