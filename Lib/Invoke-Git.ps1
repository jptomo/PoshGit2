Function Invoke-Git
{
    # Search a defined Function with Invoke-Git prefix
    $culture = [System.Globalization.CultureInfo]::GetCultureInfo("en-US")
    $targetCmdlet = "Invoke-Git$($culture.TextInfo.ToTitleCase($Args[0]))"

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
    If((Get-ChildItem Function:\ | ? { $_.Name -Eq $targetCmdlet }).Count -Gt 0)
    {
        $defaults, $keyMaps, $positionals = (Get-FuncParams $targetCmdlet)
        $argStr = ([String]::Join(' ', $Args[1..($Args.Count-1)]))
        $params = (Resolve-Args $argStr $defaults $keyMaps $positionals)
    }
    $params

    # return (& $targetCmdlet $Args[1..($Args.Count-1)])
}
