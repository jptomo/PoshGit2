If(-not (Get-Module PoshUtil)) {
    Write-Error "PoshGit2 use PoshUtil module https://github.com/jptomo/PoshUtil, Please Install it."
    return
}

. (Join-Paths $PSScriptRoot Lib Invoke-Git.ps1)

New-Alias -Name git -Value Invoke-Git

Export-ModuleMember -Function Invoke-Git
Export-ModuleMember -Alias git
