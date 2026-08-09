local bytes = require("util.bytes")

local function maskbyte_mask()
  return { 118, 184, 128 }
end

local function maskbyte_encrypt(text, key)
  local mask = maskbyte_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function maskbyte_decrypt(text, key)
  return maskbyte_encrypt(text, key)
end

return { maskbyte_mask = maskbyte_mask, maskbyte_encrypt = maskbyte_encrypt, maskbyte_decrypt = maskbyte_decrypt }
