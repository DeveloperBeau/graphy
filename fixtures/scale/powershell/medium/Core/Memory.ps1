# Single-slot memory register (M+, MR, MC).

$script:CalcMemory = 0.0

function Set-CalcMemory {
    param([double] $Value)
    $script:CalcMemory = $Value
}

function Get-CalcMemory {
    return $script:CalcMemory
}

function Clear-CalcMemory {
    $script:CalcMemory = 0.0
}
