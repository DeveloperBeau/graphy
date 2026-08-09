# Version metadata for textprint.

$script:TextPrintVersion = "2.1.0"

function Get-TextPrintVersion {
    return $script:TextPrintVersion
}

function Get-TextPrintBuildInfo {
    return "textprint $script:TextPrintVersion on PowerShell $($PSVersionTable.PSVersion.Major)"
}
