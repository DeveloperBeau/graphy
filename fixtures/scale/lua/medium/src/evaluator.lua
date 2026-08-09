local parser = require("src.parser")
local dispatch = require("src.dispatch")

local function evaluate(text)
  local stack = {}
  for _, tok in ipairs(parser.to_rpn(text)) do
    if tok.kind == "number" then
      table.insert(stack, tok.value)
    else
      local b = table.remove(stack)
      local a = table.remove(stack)
      table.insert(stack, dispatch.apply_op(tok.value, a, b))
    end
  end
  return table.remove(stack)
end

return { evaluate = evaluate }
