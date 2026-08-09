local function weavecode_encode(text)
  local k = 4
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function weavecode_decode(text)
  return weavecode_encode(text)
end

return { weavecode_encode = weavecode_encode, weavecode_decode = weavecode_decode }
