local function format_result(value)
  if value == math.floor(value) then
    return tostring(math.floor(value))
  end
  return string.format("%.4f", value)
end

local function format_line(expr, value)
  return expr .. " = " .. format_result(value)
end

return { format_result = format_result, format_line = format_line }
