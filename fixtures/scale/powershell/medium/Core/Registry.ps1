# Registry of callable library functions.

$script:CalcFunctions = @()

function Register-CalcFunction {
    param([string] $Name)
    $script:CalcFunctions += $Name
}

function Test-CalcFunction {
    param([string] $Name)
    return $script:CalcFunctions -contains $Name
}

function Get-CalcFunctionCount {
    return $script:CalcFunctions.Count
}
