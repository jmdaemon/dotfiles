# findnullfiles.ps1 - Find zero byte files
# Usage:
#   findnullfiles.ps1 -d "inputs" 

param(
    [Parameter(Mandatory=$true)][String]$d
)

# Get the null files
$null_files = Get-ChildItem -Path "${d}" -Recurse -File | Where-Object -FilterScript {$_.Length -eq 0}

foreach ($nfile in $null_files) {
    Write-Output $nfile.FullName
}