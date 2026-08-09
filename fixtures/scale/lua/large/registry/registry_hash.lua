local check_fnvhash = require("checks.check_fnvhash")
local check_djbhash = require("checks.check_djbhash")
local check_sdbmhash = require("checks.check_sdbmhash")
local check_jenkinshash = require("checks.check_jenkinshash")
local check_pearsonhash = require("checks.check_pearsonhash")
local check_foldsum = require("checks.check_foldsum")
local check_mixcrc = require("checks.check_mixcrc")
local check_tallyhash = require("checks.check_tallyhash")
local check_chainhash = require("checks.check_chainhash")
local check_weavehash = require("checks.check_weavehash")

local function hash_checks()
  return {
    { "fnvhash", check_fnvhash.check_fnvhash },
    { "djbhash", check_djbhash.check_djbhash },
    { "sdbmhash", check_sdbmhash.check_sdbmhash },
    { "jenkinshash", check_jenkinshash.check_jenkinshash },
    { "pearsonhash", check_pearsonhash.check_pearsonhash },
    { "foldsum", check_foldsum.check_foldsum },
    { "mixcrc", check_mixcrc.check_mixcrc },
    { "tallyhash", check_tallyhash.check_tallyhash },
    { "chainhash", check_chainhash.check_chainhash },
    { "weavehash", check_weavehash.check_weavehash },
  }
end

return { hash_checks = hash_checks }
