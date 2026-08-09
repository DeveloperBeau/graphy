local check_lcgstream = require("checks.check_lcgstream")
local check_driftstream = require("checks.check_driftstream")
local check_pulsestream = require("checks.check_pulsestream")
local check_cascadestream = require("checks.check_cascadestream")
local check_orbitstream = require("checks.check_orbitstream")
local check_emberstream = require("checks.check_emberstream")
local check_riverstream = require("checks.check_riverstream")
local check_sparkstream = require("checks.check_sparkstream")

local function stream_checks()
  return {
    { "lcgstream", check_lcgstream.check_lcgstream },
    { "driftstream", check_driftstream.check_driftstream },
    { "pulsestream", check_pulsestream.check_pulsestream },
    { "cascadestream", check_cascadestream.check_cascadestream },
    { "orbitstream", check_orbitstream.check_orbitstream },
    { "emberstream", check_emberstream.check_emberstream },
    { "riverstream", check_riverstream.check_riverstream },
    { "sparkstream", check_sparkstream.check_sparkstream },
  }
end

return { stream_checks = stream_checks }
