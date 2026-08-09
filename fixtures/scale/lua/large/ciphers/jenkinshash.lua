local bytes = require("util.bytes")

local function jenkinshash_digest(text)
  local h = 5381
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 33) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function jenkinshash_digest_pair(text)
  return jenkinshash_digest(text), #text
end

return { jenkinshash_digest = jenkinshash_digest, jenkinshash_digest_pair = jenkinshash_digest_pair }
