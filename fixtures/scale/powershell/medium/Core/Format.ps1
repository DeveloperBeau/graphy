# Result formatting helpers.

function Format-CalcNumber {
    param([double] $Value)
    $precision = Get-CalcSetting -Name "Precision"
    return [Math]::Round($Value, $precision).ToString()
}

function Format-CalcResult {
    param([double] $Value)
    return "= $(Format-CalcNumber -Value $Value)"
}

function Format-CalcHex {
    param([long] $Value)
    return "0x{0:x}" -f $Value
}
