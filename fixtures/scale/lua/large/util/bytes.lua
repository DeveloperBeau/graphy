local function to_codes(text)
  local out = {}
  for i = 1, #text do out[i] = text:byte(i) end
  return out
end

local function from_codes(codes)
  local chars = {}
  for i, c in ipairs(codes) do chars[i] = string.char(((c % 256) + 256) % 256) end
  return table.concat(chars)
end

local function xor_stream(codes, key_codes)
  local out = {}
  for i, c in ipairs(codes) do
    out[i] = c ~ key_codes[((i - 1) % #key_codes) + 1]
  end
  return out
end

return { to_codes = to_codes, from_codes = from_codes, xor_stream = xor_stream }
