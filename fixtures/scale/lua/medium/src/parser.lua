local lexer = require("src.lexer")
local dispatch = require("src.dispatch")

local function to_rpn(text)
  local out = {}
  local stack = {}
  for _, tok in ipairs(lexer.tokenize(text)) do
    if tok.kind == "number" then
      table.insert(out, tok)
    else
      while #stack > 0 and dispatch.precedence(stack[#stack].value) >= dispatch.precedence(tok.value) do
        table.insert(out, table.remove(stack))
      end
      table.insert(stack, tok)
    end
  end
  while #stack > 0 do table.insert(out, table.remove(stack)) end
  return out
end

return { to_rpn = to_rpn }
