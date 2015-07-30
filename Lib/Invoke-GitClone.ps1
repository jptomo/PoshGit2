. (Join-Path $PSScriptRoot _Util.ps1)

Function Invoke-GitClone
{

# TODO: Uri と Path をハンドルするようにする
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
