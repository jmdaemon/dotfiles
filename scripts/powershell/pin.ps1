# pin.ps1 - Adds folders and files to File Explorer's "Quick Access"

Set-StrictMode -Off
param(
    [Parameter(Mandatory=$true)][String]$input
)

# Read the file into an array
[String[]]$to_pin = Get-Content -Path $input

# Log message to console
echo "The following will be pinned to Quick Access:"
$to_pin | ForEach-Object {$_}

# Initialize the object
#$o = New-Object -ComObject shell.application
$output = $null
$output = New-Object -Com shell.application -Verbose
if ($output -eq $null) {
    Echo "No shell application object"
    Exit
}

# Exit if there are no folders to add
if ($to_pin -eq $null) {
    Echo "No file paths to process. Exiting..."
}

# Pin to Quick Access
ForEach($fp in $to_pin) {
    if ( $fp -eq $null ) {
        Echo "Null Value in Array, Exiting Script"
        Exit
    }
    $o = $output.Namespace($fp)
    if ($o -eq $null) {
        Echo "No Namespace available for $fp"
        Exit
    }
    Echo $o
    Echo $o.gettype()
    $o | Select-Object -Property *
    Write-Host ($o | Format-Table | Out-String)
    $o.InvokeVerb("pintohome")
}