# Command-line option defaults and parsing.

$script:BenchOptions = @{
    Rounds = 16
    SampleSize = 512
}

function Get-BenchOption {
    param([string] $Name)
    return $script:BenchOptions[$Name]
}

function Set-BenchOption {
    param(
        [string] $Name,
        [int] $Value
    )
    $script:BenchOptions[$Name] = $Value
}
