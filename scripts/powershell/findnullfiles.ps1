# findnullfiles.ps1 - Find zero byte files
# Usage:
#   findnullfiles.ps1 -d "inputs" 
#   findnullfiles.ps1 -full -d "inputs" 

param(
    [Switch]$full=$false,
    [Parameter(Mandatory=$true)][String]$d
)

# Get the null files
$null_files = Get-ChildItem -Path "${d}" -Recurse -File | Where-Object -FilterScript {$_.Length -eq 0}

if ($full) {
    # Show the file with its full path on disk
    foreach ($nfile in $null_files) {
        Write-Output $nfile.FullName
    }
} else {
    # Show just the filename
    foreach ($nfile in $null_files) {
        $stem = [System.Io.Path]::GetFileNameWithoutExtension($nfile)
        $ext = [System.IO.Path]::GetExtension($nfile)
        Write-Output "${stem}.${ext}"
    }
}