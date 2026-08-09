# Drop the fractional part.

function Get-CalcTruncate {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Truncate($Value)
}
