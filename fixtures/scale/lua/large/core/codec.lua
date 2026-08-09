local function to_hex(text)
  return (text:gsub(".", function(ch) return string.format("%02x", ch:byte()) end))
end

local function fingerprint(text)
  local total = 0
  for i = 1, #text do total = total + text:byte(i) end
  return string.format("%04x", total % 65536)
end

return { to_hex = to_hex, fingerprint = fingerprint }
