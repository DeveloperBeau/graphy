local function byteflip_encode(text)
  local k = 4
  local parts = {}
  for i = 1, #text, k do
    local chunk = text:sub(i, i + k - 1)
    parts[#parts + 1] = chunk:reverse()
  end
  return table.concat(parts)
end

local function byteflip_decode(text)
  return byteflip_encode(text)
end

return { byteflip_encode = byteflip_encode, byteflip_decode = byteflip_decode }
