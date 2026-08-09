local function turnstile_offset(text, key)
  return (key + 7) % math.max(1, #text)
end

local function turnstile_encrypt(text, key)
  local n = turnstile_offset(text, key)
  return text:sub(n + 1) .. text:sub(1, n)
end

local function turnstile_decrypt(text, key)
  local n = turnstile_offset(text, key)
  return text:sub(#text - n + 1) .. text:sub(1, #text - n)
end

return { turnstile_offset = turnstile_offset, turnstile_encrypt = turnstile_encrypt, turnstile_decrypt = turnstile_decrypt }
