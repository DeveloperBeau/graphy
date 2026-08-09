# Error slot shared by parser and evaluator.

$script:CalcError = ""

function Set-CalcError {
    param([string] $Message)
    $script:CalcError = $Message
}

function Get-CalcError {
    return $script:CalcError
}

function Clear-CalcError {
    $script:CalcError = ""
}
