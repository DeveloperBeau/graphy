local function wrap_text(text, width)
  local words = {}
  for w in text:gmatch("%S+") do table.insert(words, w) end
  local lines = {}
  local current = ""
  for _, word in ipairs(words) do
    if #current + #word + 1 > width then
      table.insert(lines, current)
      current = ""
    end
    current = current .. word .. " "
  end
  if current ~= "" then table.insert(lines, current) end
  return lines
end

return { wrap_text = wrap_text }
