local function mirrorpack_encode(text)
  local k = 3
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function mirrorpack_decode(text)
  return mirrorpack_encode(text)
end

return { mirrorpack_encode = mirrorpack_encode, mirrorpack_decode = mirrorpack_decode }
