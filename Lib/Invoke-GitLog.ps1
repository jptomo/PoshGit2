Function Invoke-GitLog
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

        ForEach($commit in $repo.Commits)
        {
            Get-Content $commit
        }
    }
}
