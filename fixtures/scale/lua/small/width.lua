local function max_width(lines)
  local best = 0
  for _, line in ipairs(lines) do
    if #line > best then best = #line end
  end
  return best
end

return { max_width = max_width }
