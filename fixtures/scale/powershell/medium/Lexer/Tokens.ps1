# Token model shared by scanner and parser.

class CalcToken {
    [string] $Type
    [string] $Value

    CalcToken([string] $type, [string] $value) {
        $this.Type = $type
        $this.Value = $value
    }

    [string] Describe() {
        return "$($this.Type):$($this.Value)"
    }
}

function New-CalcToken {
    param(
        [string] $Type,
        [string] $Value
    )
    return [CalcToken]::new($Type, $Value)
}
