Function Invoke-GitClone
{
    # TODO: fix use case of Junction directory
    # TODO: impl Depth

    <#
        .SYNOPSIS
            git clone

        .PARAMETER Depth
            alias: --depth

        .PARAMETER Branch
            alias: -b, --branch

        .PARAMETER Uri
            alias: uri

        .PARAMETER Path
            alias: path
    #>

    Param(
        [Parameter()]
        [Int]
        $Depth,
        [Parameter()]
        [String]
        $Branch,
        [Parameter(Position=0, Mandatory=$True)]
        [String]
        $Uri,
        [Parameter(Position=1)]
        [String]
        $Path
    )

    Process
    {
        If($Path -Eq '')
        {
            If($Uri -Match '/')
            {
                $last = ($Uri -Split '/' | ? {$_ -Ne '' } | select -Last 2)
            }
            Else
            {
                $last = ($Uri -Split '\' | ? {$_ -Ne '' } | select -Last 2)
            }
            If($last[1])
            {
                $dstPath = $last[1]
            }
            Else
            {
                $dstPath = $last[0]
            }
            $dstPath = (Convert-FullPath ($dstPath -Replace '.git$', ''))
        }
        Else
        {
            $dstPath = (Convert-FullPath $Path)
        }

        $options = (New-Object LibGit2Sharp.CloneOptions)
        If($Branch -Ne '')
        {
            $options.BranchName = $Branch
        }

        If($Depth -Ne 0)
        {
            # TODO: Impl: Depth Option
        }

        return [LibGit2Sharp.Repository]::Clone($Uri, $dstPath, $options)
    }
}
