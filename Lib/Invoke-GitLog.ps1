. (Join-Paths $PSScriptRoot Get-GitRepository.ps1)

Function Invoke-GitLog
{
    <#
        .SYNOPSIS

        Blah Blah Blah

        .EXAMPLE

        Invoke-GitLog

    #>
    Process
    {
        ForEach($arg in $Args) {
            Write-Host "### some $arg"
        }
    }
}
