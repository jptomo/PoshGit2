If(-not (Get-Module PoshUtil)) {
    Write-Error "PoshGit2 use PoshUtil module https://github.com/jptomo/PoshUtil, Please Install it."
    return
}

# Import Definitions

. (Join-Path $PSScriptRoot Lib\PoshGit2.ps1)

# Run Installer

Function Install-Git {
    <#
        .SYNOPSIS
        This is test Function. So that I can see.
        This is test Function. So that I can see.
        This is test Function. So that I can see.
        This is test Function. So that I can see.

        .DESCRIPTION
        HOGE FUGA PIYO PIYO.
        HOGE FUGA PIYO PIYO.
        HOGE FUGA PIYO PIYO.
        HOGE FUGA PIYO PIYO.

        .PARAMETER someName
        This is computername help.
        This is computername help.
        This is computername help.
        This is computername help.

        .EXAMPLE
        hoge example 001.
        hoge example 001.

        .EXAMPLE
        hoge example 002.
        hoge example 002.

        .EXAMPLE
        hoge example 003.
        hoge example 003.

        .EXAMPLE
        hoge example 004.
        hoge example 004.
    #>

    Begin {
        $initialized = $false
        Function initialize-Func {
            # import function to vars
            Set-Variable -Name resolveArgs -Value Resolve-Args -Scope 1

            Set-Variable -Name initialized -value $true -scope 1
        }
        initialize-Func
    }
    Process {
        If (-not $initialized) { initialize-Func }

        # parse arguments
        &$resolveArgs $Args
        # execute commands
    }
}

New-Alias -Name git -Value Install-Git

# Export
Export-ModuleMember -Function Install-Git, Get-GitRepository
Export-ModuleMember -Alias git
