local bytes = require("util.bytes")

local function lcgstream_encrypt(text, key)
  local x = (key * 7 + 177) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (29 * x + 177) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function lcgstream_decrypt(text, key)
  return lcgstream_encrypt(text, key)
end

return { lcgstream_encrypt = lcgstream_encrypt, lcgstream_decrypt = lcgstream_decrypt }
