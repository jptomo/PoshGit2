Function Join-Paths
{
    <#
        .SYNOPSIS
        Join any Paths.

        .DESCRIPTION
        copy from http://mtgpowershell.blogspot.jp/2011/09/join-path.html

        .PARAMETER someName
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

    # TODO: スペース区切りを受け入れる

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string[]]$paths
    )


    Process {
        $concated, $tail = $paths
        ForEach($path In $tail) {
            $concated = Join-Path $concated $path
        }
        return $concated
    }
}

# vim:ft=ps1 ts=4 sw=4 sts=4:
