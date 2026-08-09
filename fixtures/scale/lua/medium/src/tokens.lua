local function make_token(kind, value)
  return { kind = kind, value = value }
end

local function is_operator(ch)
  return string.find("+-*/^", ch, 1, true) ~= nil
end

return { make_token = make_token, is_operator = is_operator }
