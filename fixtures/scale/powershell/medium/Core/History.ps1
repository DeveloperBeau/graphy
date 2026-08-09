# In-memory expression history.

$script:CalcHistory = @()

function Add-CalcHistory {
    param(
        [string] $Expression,
        [double] $Result
    )
    $script:CalcHistory += "$Expression = $Result"
}

function Get-CalcHistory {
    return $script:CalcHistory
}

function Clear-CalcHistory {
    $script:CalcHistory = @()
}
