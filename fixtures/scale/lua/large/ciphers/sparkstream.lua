local bytes = require("util.bytes")

local function sparkstream_encrypt(text, key)
  local x = (key * 7 + 138) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (25 * x + 138) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function sparkstream_decrypt(text, key)
  return sparkstream_encrypt(text, key)
end

return { sparkstream_encrypt = sparkstream_encrypt, sparkstream_decrypt = sparkstream_decrypt }
