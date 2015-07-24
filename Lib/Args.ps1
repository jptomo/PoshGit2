Function Resolve-Args {
    Begin {
        $initialized = $false
        Function initialize-Func {
            Set-Variable -Name initialized -value $true -scope 1
        }
        initialize-Func
    }

    Process {
        If (-not $initialized) { initialize-Func }
        Write-Host $Args
    }
}
#
# vim:ft=ps1 ts=4 sw=4 sts=4:
