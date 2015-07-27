Function Invoke-Git
{
    Process
    {
        # Search a defined Function with Invoke-Git prefix
        $culture = [System.Globalization.CultureInfo]::GetCultureInfo("en-US")
        $targetCmdlet = "Invoke-Git$($culture.TextInfo.ToTitleCase($Args[0]))"
        try
        {
            return &$targetCmdlet $Args[1..($Args.Count-1)]
        }
        catch [System.Management.Automation.CommandNotFoundException]
        {
            # no re-action
        }

        # Search a file with Invoke-Git prefix
        $filePath = Join-Path $PSScriptRoot "${targetCmdlet}.ps1"
        If(Test-Path -Path $filePath)
        {
            . $filePath
            return &$targetCmdlet $Args[1..($Args.Count-1)]
        }

        # Throw error when no functions and no files.
        $errMsg = "${targetCmdlet} : No such Cmdlet."
        throw (New-Object System.Management.Automation.CommandNotFoundException -ArgumentList $errMsg)
    }
}
