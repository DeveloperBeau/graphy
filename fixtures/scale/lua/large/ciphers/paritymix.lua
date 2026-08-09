local bytes = require("util.bytes")

local function paritymix_mask()
  return { 125, 213, 181 }
end

local function paritymix_encrypt(text, key)
  local mask = paritymix_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function paritymix_decrypt(text, key)
  return paritymix_encrypt(text, key)
end

return { paritymix_mask = paritymix_mask, paritymix_encrypt = paritymix_encrypt, paritymix_decrypt = paritymix_decrypt }
