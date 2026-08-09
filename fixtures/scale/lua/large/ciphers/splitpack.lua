local function splitpack_encode(text)
  local k = 2
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function splitpack_decode(text)
  return splitpack_encode(text)
end

return { splitpack_encode = splitpack_encode, splitpack_decode = splitpack_decode }
