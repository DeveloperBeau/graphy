local bytes = require("util.bytes")

local function bitfold_mask()
  return { 132, 242, 234 }
end

local function bitfold_encrypt(text, key)
  local mask = bitfold_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function bitfold_decrypt(text, key)
  return bitfold_encrypt(text, key)
end

return { bitfold_mask = bitfold_mask, bitfold_encrypt = bitfold_encrypt, bitfold_decrypt = bitfold_decrypt }
