local function title_case(text)
  return (text:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest
  end))
end

return { title_case = title_case }
