. (Join-Path $PSScriptRoot PoshUtil.ps1)

Function Invoke-GitClone
{
    Process
    {
        $params = (
            Resolve-Args `
                -Arguments $Args `
                -Defaults @{'Depth'=0; 'Branch'=''; 'Uri'=''; 'Path'=''} `
                -KeyMaps @{'Depth'='--depth'; 'Branch'='-b','--branch'} `
                -Positionals 'Uri','Path')

        $path = (Convert-FullPath $params['Path'])

        $options = (New-Object LibGit2Sharp.CloneOptions)
        If($params['Branch'] -Ne '')
        {
            $options.BranchName = $params['Branch']
        }

        If($params['Depth'] -Ne 0)
        {
            # TODO: Impl: Depth Option
        }

        [LibGit2Sharp.Repository]::Clone($params['Uri'], $path, $options)
    }
}
