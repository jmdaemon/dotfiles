param(
    [Parameter()]
    [String]$i
)
# mcode.ps1 - Encodes any audio file to .wav with increases volume


# This will get the basename of a file that exists on disk
# Note that you must pass in the fully qualified path
# $base = (Get-Item $i).Basename

# This does not require a fully qualified path
$base = [io.path]::GetFileNameWithoutExtension($i)
Write-Output $base

# Converting
# volume=2.5 : Increases volume by 250%
# -r 44100   : Sets the audio frequency to 44.1hz
ffmpeg -i "$i" -filter:a "volume=2.0" -r 44100 "${base}.wav"