local bytes = require("util.bytes")

local function pearsonhash_digest(text)
  local h = 65599
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 65599) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function pearsonhash_digest_pair(text)
  return pearsonhash_digest(text), #text
end

return { pearsonhash_digest = pearsonhash_digest, pearsonhash_digest_pair = pearsonhash_digest_pair }
