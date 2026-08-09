local conv_radians = require("src.functions.conv_radians")
local conv_degrees = require("src.functions.conv_degrees")
local conv_celsius = require("src.functions.conv_celsius")
local conv_fahrenheit = require("src.functions.conv_fahrenheit")

local function convert_table()
  return {
    conv_radians = conv_radians.conv_radians,
    conv_degrees = conv_degrees.conv_degrees,
    conv_celsius = conv_celsius.conv_celsius,
    conv_fahrenheit = conv_fahrenheit.conv_fahrenheit,
  }
end

return { convert_table = convert_table }
