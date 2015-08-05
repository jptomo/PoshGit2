Function Invoke-GitStatus
{
    Process
    {
        $cwd = (Convert-Path .)
        try
        {
            $repo = (Get-GitRepository $cwd)
        }
        catch
        {
            Write-Error "fatal: Not a git repository"
            return
        }

        $options = (New-Object LibGit2Sharp.StatusOptions)
        ForEach($item In $repo.RetrieveStatus($options))
        {
            Write-Host $item.filePath
        }
    }
}
