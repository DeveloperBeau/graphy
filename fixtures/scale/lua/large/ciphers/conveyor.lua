local function conveyor_offset(text, key)
  return (key + 6) % math.max(1, #text)
end

local function conveyor_encrypt(text, key)
  local n = conveyor_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function conveyor_decrypt(text, key)
  local n = conveyor_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { conveyor_offset = conveyor_offset, conveyor_encrypt = conveyor_encrypt, conveyor_decrypt = conveyor_decrypt }
