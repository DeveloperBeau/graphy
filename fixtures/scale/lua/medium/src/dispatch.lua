local arithmetic = require("src.arithmetic")

local function apply_op(op, a, b)
  if op == "+" then return arithmetic.add(a, b) end
  if op == "-" then return arithmetic.subtract(a, b) end
  if op == "*" then return arithmetic.multiply(a, b) end
  if op == "/" then return arithmetic.divide(a, b) end
  return arithmetic.power(a, b)
end

local function precedence(op)
  local levels = { ["+"] = 1, ["-"] = 1, ["*"] = 2, ["/"] = 2, ["^"] = 3 }
  return levels[op] or 0
end

return { apply_op = apply_op, precedence = precedence }
