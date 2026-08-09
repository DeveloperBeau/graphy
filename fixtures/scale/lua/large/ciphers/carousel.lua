local function carousel_offset(text, key)
  return (key + 5) % math.max(1, #text)
end

local function carousel_encrypt(text, key)
  local n = carousel_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function carousel_decrypt(text, key)
  local n = carousel_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { carousel_offset = carousel_offset, carousel_encrypt = carousel_encrypt, carousel_decrypt = carousel_decrypt }
