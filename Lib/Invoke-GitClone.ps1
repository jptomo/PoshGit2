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

        $params
    }
}
