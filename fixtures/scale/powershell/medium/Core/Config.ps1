# Calculator settings.

$script:CalcSettings = @{
    Precision = 6
    AngleUnit = "radians"
}

function Get-CalcSetting {
    param([string] $Name)
    return $script:CalcSettings[$Name]
}

function Set-CalcPrecision {
    param([int] $Digits)
    $script:CalcSettings.Precision = $Digits
}
