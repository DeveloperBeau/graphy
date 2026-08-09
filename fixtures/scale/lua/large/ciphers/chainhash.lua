local bytes = require("util.bytes")

local function chainhash_digest(text)
  local h = 131
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 131) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function chainhash_digest_pair(text)
  return chainhash_digest(text), #text
end

return { chainhash_digest = chainhash_digest, chainhash_digest_pair = chainhash_digest_pair }
