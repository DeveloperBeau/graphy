# calc - floating point expression calculator with a function library.

. ./Core/Config.ps1
. ./Core/Errors.ps1
. ./Core/History.ps1
. ./Core/Memory.ps1
. ./Core/Format.ps1
. ./Core/Registry.ps1
. ./Core/Constants.ps1
. ./Lexer/Tokens.ps1
. ./Lexer/Scanner.ps1
. ./Parser/Expression.ps1
. ./Parser/Term.ps1
. ./Parser/Factor.ps1
. ./Evaluator.ps1
. ./Functions/Index.ps1
. ./Repl.ps1

function Show-CalcUsage {
    Write-Host "usage: Calc.ps1 [-Expression <expr>] [-Repl]"
}

function Invoke-Calc {
    param(
        [string] $Expression,
        [switch] $Repl
    )
    if ($Repl) {
        Start-CalcRepl
    } elseif ($Expression) {
        Format-CalcResult -Value (Invoke-CalcEvaluate -Expression $Expression)
    } else {
        Show-CalcUsage
    }
}
