local check_affine = require("checks.check_affine")
local check_decimation = require("checks.check_decimation")
local check_promoter = require("checks.check_promoter")
local check_modwheel = require("checks.check_modwheel")
local check_linearmix = require("checks.check_linearmix")
local check_skewmap = require("checks.check_skewmap")

local function affine_checks()
  return {
    { "affine", check_affine.check_affine },
    { "decimation", check_decimation.check_decimation },
    { "promoter", check_promoter.check_promoter },
    { "modwheel", check_modwheel.check_modwheel },
    { "linearmix", check_linearmix.check_linearmix },
    { "skewmap", check_skewmap.check_skewmap },
  }
end

return { affine_checks = affine_checks }
