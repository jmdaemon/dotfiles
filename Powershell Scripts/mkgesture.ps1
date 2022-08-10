param(
    [String]$volume="None",
    [Parameter(Mandatory=$true)][String]$i

)
# mcode.ps1 - Encodes any audio file to .wav with increases volume


# This will get the basename of a file that exists on disk
# Note that you must pass in the fully qualified path
# $base = (Get-Item $i).Basename

# This does not require a fully qualified path
$base = [io.path]::GetFileNameWithoutExtension($i)
Write-Output "Re-encoding $base"

# Re-encode audio to WAV format, with audio bitrate of 44.1Hz and optional volume increase
if($volume -eq "None") {
    ffmpeg -i "$i" -ar 44100 "${base}.wav"
} else {
    ffmpeg -i "$i" -filter:a "volume=${volume}" -ar 44100 "${base}.wav"
}