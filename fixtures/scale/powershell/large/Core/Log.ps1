# Timestamped logging for bench runs.

function Write-BenchLog {
    param(
        [string] $Level,
        [string] $Message
    )
    $stamp = (Get-Date).ToString("HH:mm:ss")
    Write-Host "$stamp [$Level] $Message"
}

function Write-BenchInfo {
    param([string] $Message)
    Write-BenchLog -Level "INFO" -Message $Message
}

function Write-BenchWarn {
    param([string] $Message)
    Write-BenchLog -Level "WARN" -Message $Message
}
