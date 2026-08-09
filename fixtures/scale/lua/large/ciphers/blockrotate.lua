local function blockrotate_offset(text, key)
  return (key + 3) % math.max(1, #text)
end

local function blockrotate_encrypt(text, key)
  local n = blockrotate_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function blockrotate_decrypt(text, key)
  local n = blockrotate_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { blockrotate_offset = blockrotate_offset, blockrotate_encrypt = blockrotate_encrypt, blockrotate_decrypt = blockrotate_decrypt }
