local bytes = require("util.bytes")

local function staticpad_mask()
  return { 160, 102, 190 }
end

local function staticpad_encrypt(text, key)
  local mask = staticpad_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function staticpad_decrypt(text, key)
  return staticpad_encrypt(text, key)
end

return { staticpad_mask = staticpad_mask, staticpad_encrypt = staticpad_encrypt, staticpad_decrypt = staticpad_decrypt }
