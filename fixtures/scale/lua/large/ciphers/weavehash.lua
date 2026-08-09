local bytes = require("util.bytes")

local function weavehash_digest(text)
  local h = 8191
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 37) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function weavehash_digest_pair(text)
  return weavehash_digest(text), #text
end

return { weavehash_digest = weavehash_digest, weavehash_digest_pair = weavehash_digest_pair }
