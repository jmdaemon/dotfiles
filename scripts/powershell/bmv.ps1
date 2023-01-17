# bmv.ps1 - Batch move files
# Usage: bmv.ps1 -p "-10dB" -s output -d "10dB"

param(
    [Parameter(Mandatory=$true)][String]$p,
    [Parameter(Mandatory=$true)][String]$s,
    [Parameter(Mandatory=$true)][String]$d
)

function batch_move($pattern, $source, $destination) {
    if (-not (Test-Path $destination)) { mkdir $destination | out-null }

    foreach ($i in Get-ChildItem -Path $source -Recurse) {
        if (($i.Name -match $pattern) -and (-not $i.PsIsContainer)) {
            continue;
        } else {
            Copy-Item -Path "$i".FullName -Destination $i.FullName.Replace($source, $destination).Trim("$i".Name)
        }
    }
}
batch_move "$p" "$s" "$d"