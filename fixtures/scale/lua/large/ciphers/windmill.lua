local function windmill_offset(text, key)
  return (key + 1) % math.max(1, #text)
end

local function windmill_encrypt(text, key)
  local n = windmill_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function windmill_decrypt(text, key)
  local n = windmill_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { windmill_offset = windmill_offset, windmill_encrypt = windmill_encrypt, windmill_decrypt = windmill_decrypt }
