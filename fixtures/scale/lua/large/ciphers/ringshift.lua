local function ringshift_offset(text, key)
  return (key + 4) % math.max(1, #text)
end

local function ringshift_encrypt(text, key)
  local n = ringshift_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function ringshift_decrypt(text, key)
  local n = ringshift_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { ringshift_offset = ringshift_offset, ringshift_encrypt = ringshift_encrypt, ringshift_decrypt = ringshift_decrypt }
