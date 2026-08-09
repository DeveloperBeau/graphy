local function to_upper(text)
  return string.upper(text)
end

local function repeat_char(ch, n)
  return string.rep(ch, n)
end

local function underline(text)
  return text .. "\n" .. repeat_char("-", #text)
end

return { to_upper = to_upper, repeat_char = repeat_char, underline = underline }
