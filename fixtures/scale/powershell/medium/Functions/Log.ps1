# Natural logarithm.

function Get-CalcLog {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Log($Value)
}
