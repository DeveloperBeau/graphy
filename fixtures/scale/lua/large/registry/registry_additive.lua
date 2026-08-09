local check_caesar = require("checks.check_caesar")
local check_gronsfeld = require("checks.check_gronsfeld")
local check_trithemius = require("checks.check_trithemius")
local check_shiftreel = require("checks.check_shiftreel")
local check_stairstep = require("checks.check_stairstep")
local check_augustus = require("checks.check_augustus")
local check_keypad = require("checks.check_keypad")
local check_ordinal = require("checks.check_ordinal")

local function additive_checks()
  return {
    { "caesar", check_caesar.check_caesar },
    { "gronsfeld", check_gronsfeld.check_gronsfeld },
    { "trithemius", check_trithemius.check_trithemius },
    { "shiftreel", check_shiftreel.check_shiftreel },
    { "stairstep", check_stairstep.check_stairstep },
    { "augustus", check_augustus.check_augustus },
    { "keypad", check_keypad.check_keypad },
    { "ordinal", check_ordinal.check_ordinal },
  }
end

return { additive_checks = additive_checks }
