Function Invoke-GitFetch
{
    <#
        .SYNOPSIS
            git fetch [<repository> [<refspec>...]]

        .PARAMETER Repository
            alias: repository
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Position=0)]
        [String]
        $Repository = 'origin'
    )

    Process
    {
        try
        {
            $repo = (Get-GitRepository (Convert-Path .))
        }
        catch
        {
            Write-Error "fatal: Not a git repository"
            Return
        }

        $repo.Network.Fetch($repo.Network.Remotes[$Repository])
    }
}
