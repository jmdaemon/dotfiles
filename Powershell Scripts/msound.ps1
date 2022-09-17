# msound.ps1 - Rencodes any audio file to .wav with increases volume using Ffmpeg
# Usage: msound.ps1 -in "input.mp3" -out "output.wav" 

param(
    [String]$volume="None",
    [Parameter(Mandatory=$true)][String]$in,
    [Parameter(Mandatory=$true)][String]$out
)

# Re-encode audio to WAV format, with audio bitrate of 44.1Hz and optional volume increase
if ($volume -eq "None") {
    Write-Output "ffmpeg -ar 44100 -i \"$in\" \"$out\""
    ffmpeg -i "$in" -ar 44100  "$out"
} else {
    Write-Output "ffmpeg -ar 44100 -i "$in" -filter:a \"volume=${volume}\" \"$out\""
    ffmpeg -i "$in" -ar 44100 -filter:a "volume=${volume}" "$out"
}