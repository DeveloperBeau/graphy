local bytes = require("util.bytes")

local function djbhash_digest(text)
  local h = 131071
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 43) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function djbhash_digest_pair(text)
  return djbhash_digest(text), #text
end

return { djbhash_digest = djbhash_digest, djbhash_digest_pair = djbhash_digest_pair }
