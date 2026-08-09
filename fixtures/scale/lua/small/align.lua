local function align_center(line, width)
  local gap = math.max(0, width - #line)
  local left = math.floor(gap / 2)
  return string.rep(" ", left) .. line .. string.rep(" ", gap - left)
end

return { align_center = align_center }
