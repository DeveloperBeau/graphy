local check_xorkey = require("checks.check_xorkey")
local check_maskbyte = require("checks.check_maskbyte")
local check_paritymix = require("checks.check_paritymix")
local check_bitfold = require("checks.check_bitfold")
local check_veilmask = require("checks.check_veilmask")
local check_dualmask = require("checks.check_dualmask")
local check_nibblexor = require("checks.check_nibblexor")
local check_staticpad = require("checks.check_staticpad")

local function mask_checks()
  return {
    { "xorkey", check_xorkey.check_xorkey },
    { "maskbyte", check_maskbyte.check_maskbyte },
    { "paritymix", check_paritymix.check_paritymix },
    { "bitfold", check_bitfold.check_bitfold },
    { "veilmask", check_veilmask.check_veilmask },
    { "dualmask", check_dualmask.check_dualmask },
    { "nibblexor", check_nibblexor.check_nibblexor },
    { "staticpad", check_staticpad.check_staticpad },
  }
end

return { mask_checks = mask_checks }
