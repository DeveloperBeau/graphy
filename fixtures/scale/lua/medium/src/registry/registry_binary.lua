local bi_arctangent = require("src.functions.bi_arctangent")
local bi_remainder = require("src.functions.bi_remainder")
local bi_maximum = require("src.functions.bi_maximum")
local bi_minimum = require("src.functions.bi_minimum")
local bi_hypotenuse = require("src.functions.bi_hypotenuse")

local function binary_table()
  return {
    bi_arctangent = bi_arctangent.bi_arctangent,
    bi_remainder = bi_remainder.bi_remainder,
    bi_maximum = bi_maximum.bi_maximum,
    bi_minimum = bi_minimum.bi_minimum,
    bi_hypotenuse = bi_hypotenuse.bi_hypotenuse,
  }
end

return { binary_table = binary_table }
