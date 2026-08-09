# Deterministic sample bytes for benchmark runs.

$script:CorpusBase = "the quick brown fox jumps over the lazy dog 0123456789"

function Get-CorpusText {
    param([int] $Length)
    $out = ""
    while ($out.Length -lt $Length) {
        $out += "$script:CorpusBase "
    }
    return $out.Substring(0, $Length)
}

function Get-CorpusSample {
    param([int] $Length = 512)
    return [System.Text.Encoding]::ASCII.GetBytes((Get-CorpusText -Length $Length))
}
