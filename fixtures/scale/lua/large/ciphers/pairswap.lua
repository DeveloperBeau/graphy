local function pairswap_encode(text)
  local k = 2
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function pairswap_decode(text)
  return pairswap_encode(text)
end

return { pairswap_encode = pairswap_encode, pairswap_decode = pairswap_decode }
