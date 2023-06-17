function ln ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function prof($editor) {
	$edit="$editor $Profile"
	Invoke-Expression($edit)
}


function srcprof {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | % {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }    
}
