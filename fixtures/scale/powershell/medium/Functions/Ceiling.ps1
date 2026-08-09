# Round toward positive infinity.

function Get-CalcCeiling {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Ceiling($Value)
}
