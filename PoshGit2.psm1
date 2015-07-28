If(-not (Get-Module PoshUtil)) {
    Write-Error "PoshGit2 use PoshUtil module https://github.com/jptomo/PoshUtil, Please Install it."
    return
}

. (Join-Paths $PSScriptRoot Lib Get-GitRepository.ps1)
. (Join-Paths $PSScriptRoot Lib Invoke-Git.ps1)

New-Alias -Name git -Value Invoke-Git

Export-ModuleMember -Function Invoke-Git, Get-GitRepository
Export-ModuleMember -Alias git
