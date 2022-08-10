param(
    [Parameter()]
    [String]$i
)
$base = [io.path]::GetFileNameWithoutExtension($i)
Write-Output $base
ffmpeg -i "$i"-ar 44100 -filter:a "volume=1.5" "${base}.wav"