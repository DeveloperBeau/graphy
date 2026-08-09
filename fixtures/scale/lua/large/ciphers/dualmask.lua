local bytes = require("util.bytes")

local function dualmask_mask()
  return { 146, 44, 84 }
end

local function dualmask_encrypt(text, key)
  local mask = dualmask_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function dualmask_decrypt(text, key)
  return dualmask_encrypt(text, key)
end

return { dualmask_mask = dualmask_mask, dualmask_encrypt = dualmask_encrypt, dualmask_decrypt = dualmask_decrypt }
