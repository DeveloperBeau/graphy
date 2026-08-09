local function guard_number(x)
  local value = tonumber(x)
  if value ~= value then error("not a number") end
  return value
end

local function guard_positive(x)
  local value = guard_number(x)
  if value <= 0 then error("must be positive") end
  return value
end

return { guard_number = guard_number, guard_positive = guard_positive }
