local bytes = require("util.bytes")

local function xorkey_mask()
  return { 111, 155, 75 }
end

local function xorkey_encrypt(text, key)
  local mask = xorkey_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function xorkey_decrypt(text, key)
  return xorkey_encrypt(text, key)
end

return { xorkey_mask = xorkey_mask, xorkey_encrypt = xorkey_encrypt, xorkey_decrypt = xorkey_decrypt }
