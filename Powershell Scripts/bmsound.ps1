# bmsound.ps1 - Rencodes any audio file to .wav with increases volume using Ffmpeg
# Usage:
#   bmound.ps1 -d "inputs" -o "output_directory"
#   bmound.ps1 -e "exclude_file1,exclude_file2" -d "inputs"
#   bmound.ps1 -v "20dB" -e "exclude_file1,exclude_file2" -d "sounds" -o "sounds-20dB"

param(
    [String]$excludes="None",
    [String]$o="None",
    [String]$v="None",
    [Parameter(Mandatory=$true)][String]$d
)

# Volume, Input File, Output File
function encode ($volume, $i, $o) {
    # Re-encode audio to WAV format, with audio bitrate of 44.1Hz and optional volume increase
    if ($volume -eq "None") {
        Write-Output "ffmpeg -ar 44100 -i \"$i\" \"$o\""
        ffmpeg -i "$i" -ar 44100  "$o"
    } else {
        Write-Output "ffmpeg -ar 44100 -i "$i" -filter:a \"volume=${volume}\" \"$o\""
        ffmpeg -i "$i" -ar 44100 -filter:a "volume=${volume}" "$o"
    }
}

# Files with a volume boost get renamed with a -${volume} name. E.g
# file.wav
# file-20dB.wav
$output_fmt = ""
if ($v -ne "None") {
    $output_fmt = "-${v}"
}

# Custom output directory, defaults to 'output' of the directory specified with -d
$output_dir = ""
if ($o -ne "None") {
    $output_dir = $o
}
else {
    $parent_dir = (get-item $d).parent.FullName
    $output_dir = "${parent_dir}/output"
}

# Make the new directory
new-item $output_dir -itemtype directory

# Batch encode all the files
$files = Get-ChildItem "$d"
foreach ($f in $files){
    $filename = $f.FullName
    $stem = [System.Io.Path]::GetFileNameWithoutExtension($f)
    $ext = [System.IO.Path]::GetExtension($f)
    $output = "${stem}${output_fmt}${ext}"

    $output_file = "${output_dir}/${output}"
    Write-Output("volume: ${v}")
    Write-Output("filename: ${filename}")
    Write-Output("output: ${output}")
    encode $v $filename $output_file
}