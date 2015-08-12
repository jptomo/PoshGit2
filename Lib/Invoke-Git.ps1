Function Invoke-Git
{
    Switch ($Args[0])
    {
        'st'    { $srcCmd = 'status' }
        'ci'    { $srcCmd = 'commit' }
        default { $srcCmd = $Args[0] }
    }

    # Search a defined Function with Invoke-Git prefix
    $culture = [System.Globalization.CultureInfo]::GetCultureInfo("en-US")
    $targetCmdlet = "Invoke-Git$($culture.TextInfo.ToTitleCase($srcCmd))"

    # Search a file with Invoke-Git prefix
    If((Get-ChildItem Function:\ | ? { $_.Name -Eq $targetCmdlet }).Count -Eq 0)
    {
        $filePath = Join-Path $PSScriptRoot "${targetCmdlet}.ps1"
        If(Test-Path -Path $filePath)
        {
            . $filePath
        }
    }

    # Parse Args
    $cmdParams = ''
    if ((Get-ChildItem Function:\ | ? { $_.Name -Eq $targetCmdlet }).Count -Gt 0)
    {
        $defaults, $keyMaps, $positionals = (Get-FuncParams $targetCmdlet)
        $argStr = ''
        if ($Args.Count > 1)
        {
            $argStr = ([String]::Join(' ', $Args[1..($Args.Count-1)]))
        }
        $params = (Resolve-Args $argStr $defaults $keyMaps $positionals)

        ForEach($key in $keyMaps.Keys)
        {
            $param = $params[$key]
            If($param -Ne $defaults[$key])
            {
                $cmdParams += " -${key} ${param}"
            }
        }
        ForEach($key in $positionals)
        {
            $param = $params[$key]
            If($param -Ne $defaults[$key])
            {
                $cmdParams += " ${param}"
            }
        }
        $cmdParams = $cmdParams.Trim()
    }

    return Invoke-Expression ([String]::Join(' ', $targetCmdlet, $cmdParams))
}
