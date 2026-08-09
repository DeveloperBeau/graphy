# Bench tuning knobs with environment overrides.

$script:BenchSettings = @{
    Warmup = if ($env:CIPHBENCH_WARMUP) { [int]$env:CIPHBENCH_WARMUP } else { 2 }
    Verbose = $env:CIPHBENCH_VERBOSE -eq "1"
}

function Get-BenchSetting {
    param([string] $Name)
    return $script:BenchSettings[$Name]
}

function Test-VerboseBench {
    return [bool](Get-BenchSetting -Name "Verbose")
}
