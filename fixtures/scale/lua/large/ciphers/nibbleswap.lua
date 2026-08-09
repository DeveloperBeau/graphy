local function nibbleswap_encode(text)
  local k = 3
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function nibbleswap_decode(text)
  return nibbleswap_encode(text)
end

return { nibbleswap_encode = nibbleswap_encode, nibbleswap_decode = nibbleswap_decode }
