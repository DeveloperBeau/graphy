# Leveled logging to the information stream.

function Write-TextPrintLog {
    param(
        [string] $Level,
        [string] $Message
    )
    Write-Host "[$Level] $Message"
}

function Write-InfoLog {
    param([string] $Message)
    Write-TextPrintLog -Level "INFO" -Message $Message
}

function Write-WarnLog {
    param([string] $Message)
    Write-TextPrintLog -Level "WARN" -Message $Message
}
