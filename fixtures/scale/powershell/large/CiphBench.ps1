# ciphbench - throughput and round-trip checks for toy ciphers.

. ./Core/Log.ps1
. ./Core/Config.ps1
. ./Core/Args.ps1
. ./Core/Timer.ps1
. ./Core/Corpus.ps1
. ./Core/Store.ps1
. ./Core/Csv.ps1
. ./Core/Progress.ps1
. ./Core/Registry.ps1
. ./Core/Format.ps1
. ./Core/Report.ps1
. ./Core/Summary.ps1
. ./Core/Run.ps1
. ./Ciphers/IndexShift.ps1
. ./Ciphers/IndexVigenere.ps1
. ./Ciphers/IndexStream.ps1
. ./Ciphers/IndexTransposition.ps1
. ./Ciphers/IndexHash.ps1

function Show-CiphBenchUsage {
    Write-Host "usage: CiphBench.ps1 <run|report|verify>"
}

function Invoke-CiphBench {
    param([string[]] $Arguments)
    switch ($Arguments[0]) {
        "run" { Invoke-BenchAll }
        "report" { Show-BenchReport }
        "verify" { Test-AllCiphers }
        default { Show-CiphBenchUsage }
    }
}

Invoke-CiphBench -Arguments $args
