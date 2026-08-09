local function laddercode_encode(text)
  local k = 3
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function laddercode_decode(text)
  return laddercode_encode(text)
end

return { laddercode_encode = laddercode_encode, laddercode_decode = laddercode_decode }
