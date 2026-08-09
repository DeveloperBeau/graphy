local function unknown_cipher(name)
  return "unknown cipher: " .. name
end

local function roundtrip_failed(name)
  return "round trip mismatch: " .. name
end

return { unknown_cipher = unknown_cipher, roundtrip_failed = roundtrip_failed }
