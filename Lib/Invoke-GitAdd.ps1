Function Invoke-GitAdd
{
    <#
        .SYNOPSIS
            git fetch [<repository> [<refspec>...]]

        .PARAMETER Pathspec
            alias: Pathspec
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Position=0)]
        [String]
        $Pathspec
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
            return
        }

        if ([String]::IsNullOrEmpty($Pathspec))
        {
            Write-Error 'Nothing specified, nothing added. Maybe you wanted to say ''git add .''?'
        }
        elseif (-not (Test-Path -Path $Pathspec))
        {
            Write-Error 'fatal: pathspec ''hoge'' did not match any files'
        }
        else
        {
            $repo.Index.Add($Pathspec);
        }
    }
}

