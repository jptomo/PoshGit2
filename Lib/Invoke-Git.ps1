. (Join-Paths $PSScriptRoot Invoke-GitLog.ps1)

Function Invoke-Git
{
    Begin
    {
        $setupDone = $false
        Function initialize-Func
        {
            Set-Variable -Name git-log -Value Invoke-GitLog -Scope 1

            Set-Variable -Name setupDone -Value $true -Scope 1
        }
        initialize-Func
    }
    Process
    {
        If (-not $setupDone) { initialize-Func }

        If ($Args[0] -eq "log") {(&${git-log} $Args[1..($Args.Count - 1)])}
        # 変数を探す
        # 変数がない場合、えらーをあげる
    }

}
