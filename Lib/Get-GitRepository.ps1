. (Join-Path $PSScriptRoot PoshUtil.ps1)

# def dllPath
Add-Type -Path (Join-Paths $PSScriptRoot libgit2sharp LibGit2Sharp.dll)

Function Get-GitRepository
{
    <#
        .SYNOPSIS

        Return libgit2sharp Repository Instance.

        .PARAMETER Path

        Path to git Repository.

        .EXAMPLE

        Get-GitRepository path\to\git\repo

    #>

    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string]$Path
    )

    Process {
        $realPath = (Resolve-Path $Path)
        return (New-Object -TypeName LibGit2Sharp.Repository -ArgumentList $realPath)
    }
}
