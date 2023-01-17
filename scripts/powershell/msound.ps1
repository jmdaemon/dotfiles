# msound.ps1 - Rencodes any audio file to .wav with increases volume using Ffmpeg
# Usage: msound.ps1 -i "input.mp3" -o "output.wav" 

param(
    [String]$volume="None",
    [Parameter(Mandatory=$true)][String]$i,
    [Parameter(Mandatory=$true)][String]$o
)

# Re-encode audio to WAV format, with audio bitrate of 44.1Hz and optional volume increase
if ($volume -eq "None") {
    Write-Output "ffmpeg -ar 44100 -i \"$i\" \"$o\""
    ffmpeg -i "$i" -ar 44100  "$o"
} else {
    Write-Output "ffmpeg -ar 44100 -i "$i" -filter:a \"volume=${volume}\" \"$o\""
    ffmpeg -i "$i" -ar 44100 -filter:a "volume=${volume}" "$o"
}