local THEMES = {
  plain = { corner = "+", edge = "-" },
  star = { corner = "*", edge = "*" },
}

local function chars(name)
  return THEMES[name] or THEMES.plain
end

return { chars = chars }
