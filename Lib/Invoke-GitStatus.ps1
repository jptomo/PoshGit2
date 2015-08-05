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

        $status2text =
        {
            Param(
                [LibGit2Sharp.StatusEntry]$item
            )

            Process
            {
                $entries = [LibGit2Sharp.StatusEntry]
                $statusDict = @{
                    'Modified' = 'M ';
                    'ModifiedInWorkdir' = ' M';
                }

                return $statusDict[$item.state.ToString()]
            }
        }

        $options = (New-Object LibGit2Sharp.StatusOptions)
        ForEach($item In $repo.RetrieveStatus($options))
        {
            Write-Host "$(&$status2text $item) $($item.filePath)"
        }
    }
}
