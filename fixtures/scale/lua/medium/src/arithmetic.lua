local function add(a, b)
  return a + b
end

local function subtract(a, b)
  return a - b
end

local function multiply(a, b)
  return a * b
end

local function divide(a, b)
  if b == 0 then error("divide by zero") end
  return a / b
end

local function power(a, b)
  return a ^ b
end

return { add = add, subtract = subtract, multiply = multiply, divide = divide, power = power }
