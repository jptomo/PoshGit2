. (Join-Path $PSScriptRoot PoshUtil.ps1)

Function Invoke-GitClone
{
    # TODO: Junction を取り扱えるようにする

    <#
        .SYNOPSIS
            git clone

        .NOTES
            Depth: --depth
            Branch: -b, --branch
    #>

    Process
    {
        $params = (
            Resolve-Args `
                -Arguments $Args `
                -Defaults @{'Depth'=0; 'Branch'=''; 'Uri'=''; 'Path'=''} `
                -KeyMaps @{'Depth'='--depth'; 'Branch'='-b','--branch'} `
                -Positionals 'Uri','Path')

        If($params['Path'] -Eq '')
        {
            If($params['Uri'] -Match '/')
            {
                $last = ($params['Uri'] -Split '/' | ? {$_ -Ne '' } | select -Last 2)
            }
            Else
            {
                $last = ($params['Uri'] -Split '\' | ? {$_ -Ne '' } | select -Last 2)
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
            $dstPath = (Convert-FullPath $params['Path'])
        }

        $options = (New-Object LibGit2Sharp.CloneOptions)
        If($params['Branch'] -Ne '')
        {
            $options.BranchName = $params['Branch']
        }

        If($params['Depth'] -Ne 0)
        {
            # TODO: Impl: Depth Option
        }

        return [LibGit2Sharp.Repository]::Clone($params['Uri'], $dstPath, $options)
    }
}
