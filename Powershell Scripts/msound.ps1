# msound.ps1 - Rencodes any audio file to .wav with increases volume using Ffmpeg

param(
    [String]$volume="None",
    [Parameter(Mandatory=$true)][String]$in,
    [Parameter(Mandatory=$true)][String]$out
)

# Re-encode audio to WAV format, with audio bitrate of 44.1Hz and optional volume increase
if ($volume -eq "None") {
    ffmpeg -i "$i" -ar 44100 "${out}"
} else {
    ffmpeg -i "$i" -ar 44100 -filter:a "volume=${volume}" "${out}"
}