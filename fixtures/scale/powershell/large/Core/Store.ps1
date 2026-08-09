# Append-only results file under the working directory.

$script:ResultsPath = if ($env:CIPHBENCH_RESULTS) { $env:CIPHBENCH_RESULTS } else { "results.csv" }

function Initialize-ResultStore {
    Set-Content -Path $script:ResultsPath -Value @()
}

function Add-ResultRow {
    param([string] $Row)
    Add-Content -Path $script:ResultsPath -Value $Row
}

function Get-ResultPath {
    return $script:ResultsPath
}
