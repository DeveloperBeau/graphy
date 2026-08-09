# Named mathematical constants.

$script:CalcConstants = @{
    pi = [Math]::PI
    e = [Math]::E
    tau = 2.0 * [Math]::PI
}

function Get-CalcConstant {
    param([string] $Name)
    if (-not $script:CalcConstants.ContainsKey($Name)) {
        throw "unknown constant $Name"
    }
    return $script:CalcConstants[$Name]
}
