local tokens = require("src.tokens")

local function tokenize(text)
  local out = {}
  local i = 1
  while i <= #text do
    local ch = text:sub(i, i)
    if ch == " " then
      i = i + 1
    elseif ch:match("[0-9.]") then
      local j = i
      while j <= #text and text:sub(j, j):match("[0-9.]") do j = j + 1 end
      table.insert(out, tokens.make_token("number", tonumber(text:sub(i, j - 1))))
      i = j
    else
      table.insert(out, tokens.make_token("op", ch))
      i = i + 1
    end
  end
  return out
end

return { tokenize = tokenize }
