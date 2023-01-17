# bmsound.ps1 - Rencodes any audio file to .wav with increases volume using Ffmpeg
# Usage:
#   bmound.ps1 -d "inputs" -o "output_directory"
#   bmound.ps1 -e "exclude_file1,exclude_file2" -d "inputs"
#   bmound.ps1 -v "20dB" -e "exclude_file1,exclude_file2" -d "sounds" -o "sounds-20dB"
#   bmound.ps1 -d "inputs.txt" -v "20dB"

param(
    [String]$e="None",
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
        Write-Output "ffmpeg -ar 44100 -i '$i' -filter:a 'volume=${volume}' '$o'"
        ffmpeg -i "$i" -ar 44100 -filter:a "volume=${volume}" "$o"
    }
}

function log_args($volume, $filename, $output_file) {
    Write-Output "volume: ${volume}"
    Write-Output "filename: ${filename}"
    Write-Output "output_file: ${output_file}"
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
    if ($parent_dir -eq $null) {
        $output_dir = "output"
    } else {
        $output_dir = "${parent_dir}\output"
    }
}

# Make the new directory, if it doesn't already exist
if (Test-Path $output_dir) {
    Write-Output "Folder Exists: $output_dir"
} else {
    new-item $output_dir -itemtype directory
}

if (Test-Path $d -PathType Container) {
    # Exclude files from output
    $COMMA_SEPARATED = ','
    $exclude_files = @()
    $match = $e | Select-String -Pattern $COMMA_SEPARATED

    if ($match -ne $null) {
        $exclude_files = $e.Split($COMMA_SEPARATED)
    } else {
        $exclude_files += $e
    }
    Write-Output $exclude_files

    # Batch encode all the files
    $files = Get-ChildItem "$d"

    foreach ($f in $files) {
        $filename = $f.FullName
        $stem = [System.Io.Path]::GetFileNameWithoutExtension($f)
        $ext = [System.IO.Path]::GetExtension($f)
        $output = "${stem}${output_fmt}${ext}"

        $output_file = ""
        if ($output_dir -ne "") {
            $output_file = "${output_dir}\${output}"
        } else {
            $output_file = $output
        }

        log_args $v $filename $output_file

        # Skip excluded files
        foreach ($exclude in $exclude_files) {
            Write-Output "exclude: $exclude"
            if ("${stem}${ext}" -ne $exclude) {
                encode $v $filename $output_file
            }
        }
    }
} else {
    # Assume -d is a list of sounds separated by newlines
    [String[]]$lines = Get-Content -Path "$d"

    $cwd = Get-Location
    cd $output_dir
    if ($v -eq "None") {
        foreach ($line in $lines) { gtts "$line" }
    } else {
        foreach ($line in $lines) { gtts "$line" -r -vol "${v}"}
    }
    cd $cwd
}