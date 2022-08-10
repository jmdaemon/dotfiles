param(
    [Parameter()]
    [String]$i
)
$base = [io.path]::GetFileNameWithoutExtension($i)
Write-Output $base
ffmpeg -i "$i"-r 44100 "${base}.wav"