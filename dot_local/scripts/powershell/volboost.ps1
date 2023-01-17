# volboost.ps1 - Boosts v of audio files
# Usage: volboost.ps1 -i "input.mp3" -o "output.wav" 

param(
    [Parameter(Mandatory=$true)][String]$v,
    [Parameter(Mandatory=$true)][String]$i
)
#$file = (Get-Item "$i").Basename
$file = [System.Io.Path]::GetFileNameWithoutExtension($i)
# $ext = (Get-Item "$i").Extension
$ext = [System.IO.Path]::GetExtension($i)

$output="${file}-${v}${ext}"
Write-Output "${output}"

Write-Output "ffmpeg -ar 44100 -i "$i" -filter:a \"volume=${v}\" \"$output\""
ffmpeg -i "$i" -filter:a "volume=${v}" -ar 44100 "$output"