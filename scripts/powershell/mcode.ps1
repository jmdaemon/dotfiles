# mcode.ps1 - Rencodes any audio file to .wav with increases volume using Ffmpeg

param(
    [String]$volume="None",
    [Parameter(Mandatory=$true)][String]$i
)

$base = [io.path]::GetFileNameWithoutExtension($i)
Write-Output "Re-encoding $base"

# Re-encode audio to WAV format, with audio bitrate of 44.1Hz and optional volume increase
if($volume -eq "None") {
    ffmpeg -i "$i" -ar 44100 "${base}.wav"
} else {
    ffmpeg -i "$i" -filter:a "volume=${volume}" -ar 44100 "${base}.wav"
}