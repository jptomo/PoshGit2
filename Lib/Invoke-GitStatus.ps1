Function Invoke-GitStatus
{
    Process
    {
        $cwd = (Convert-Path .)
        Try
        {
            $repo = (Get-GitRepository $cwd)
        }
        Catch
        {
            Write-Error "fatal: Not a git repository"
            Return
        }

        $status2text =
        {
            Param([LibGit2Sharp.StatusEntry]$item)

            Process
            {
                Switch($item.state)
                {
                    'Modified'        { Return 'M ' }
                    'ModifiedWorkdir' { Return ' M' }
                    default           { Return $item.state.ToString() }
                }
            }

        }

        $options = (New-Object LibGit2Sharp.StatusOptions)
        ForEach($item In $repo.RetrieveStatus($options))
        {
            Write-Host "$(&$status2text $item) $($item.filePath)"
        }
    }
}
