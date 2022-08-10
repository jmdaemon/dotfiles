Set-StrictMode -Off
$to_pin=@(

)
echo "The following will be pinned to Quick Access:"
$to_pin | ForEach-Object {$_}

# Pin to Quick Access
#$o = New-Object -ComObject shell.application
$output = $null
$output = New-Object -Com shell.application -Verbose
if ($output -eq $null) {
    Echo "No shell application object"
    Exit
}

if ($to_pin -eq $null) {
    Echo "No file paths to process. Exiting..."
 }

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

#$o.NameSpace("E:\Program Files (x86)\Steam\userdata\287639416\760\remote\4000\screenshots").Self.InvokeVerb("pintohome")