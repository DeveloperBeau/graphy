local bytes = require("util.bytes")

local function cascadestream_encrypt(text, key)
  local x = (key * 7 + 14) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (9 * x + 14) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function cascadestream_decrypt(text, key)
  return cascadestream_encrypt(text, key)
end

return { cascadestream_encrypt = cascadestream_encrypt, cascadestream_decrypt = cascadestream_decrypt }
