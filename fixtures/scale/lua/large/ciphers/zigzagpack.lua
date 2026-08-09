local function zigzagpack_encode(text)
  local k = 4
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function zigzagpack_decode(text)
  return zigzagpack_encode(text)
end

return { zigzagpack_encode = zigzagpack_encode, zigzagpack_decode = zigzagpack_decode }
