# Inverse tangent.

function Get-CalcAtan {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Atan($Value)
}
