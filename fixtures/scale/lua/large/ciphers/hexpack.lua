local function hexpack_encode(text)
  local k = 2
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function hexpack_decode(text)
  return hexpack_encode(text)
end

return { hexpack_encode = hexpack_encode, hexpack_decode = hexpack_decode }
