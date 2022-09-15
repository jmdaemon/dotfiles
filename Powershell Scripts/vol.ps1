# vol.ps1 - Shows the mean/max level of any audio file with Ffmpeg

param(
    [Parameter(Mandatory=$true)][String]$sound
)

ffmpeg -i "${sound}" -filter:a volumedetect -f null NUL