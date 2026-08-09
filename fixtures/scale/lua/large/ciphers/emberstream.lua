local bytes = require("util.bytes")

local function emberstream_encrypt(text, key)
  local x = (key * 7 + 76) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (17 * x + 76) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function emberstream_decrypt(text, key)
  return emberstream_encrypt(text, key)
end

return { emberstream_encrypt = emberstream_encrypt, emberstream_decrypt = emberstream_decrypt }
