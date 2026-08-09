local bytes = require("util.bytes")

local function riverstream_encrypt(text, key)
  local x = (key * 7 + 107) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (21 * x + 107) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function riverstream_decrypt(text, key)
  return riverstream_encrypt(text, key)
end

return { riverstream_encrypt = riverstream_encrypt, riverstream_decrypt = riverstream_decrypt }
