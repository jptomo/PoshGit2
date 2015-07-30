Function Join-Paths
{
    <#
        .SYNOPSIS

        Join any Paths.

        .DESCRIPTION

        copy from http://mtgpowershell.blogspot.jp/2011/09/join-path.html

        .EXAMPLE

        Join-Paths foo bar baz
        foo\bar\baz

    #>

    Process {
        $concated, $tail = $Args
        ForEach($path In $tail) {
            $concated = Join-Path $concated $path
        }
        return $concated
    }
}


Function Resolve-Args
{
    [CmdletBinding()]
    param(
        [Object[]]$Arguments,
        $Defaults,
        $KeyMaps,
        $Positionals
    )

    Process
    {
        $params = $Defaults

        $maps = @{}
        ForEach($k in $KeyMaps.Keys)
        {
            If($KeyMaps[$k] -is [Object[]])
            {
                ForEach($x in $KeyMaps[$k])
                {
                    $maps[$x] = $k
                }
            }
            Else
            {
                $maps[$KeyMaps[$k]] = $k
            }
        }

        $arguments = ($Arguments | select)
        $pos = @()
        For($i = 0; $i -lt $arguments.Count; $i += 1)
        {
            If($maps.Keys -contains $arguments[$i])
            {
                $params[$maps[$arguments[$i]]] = $arguments[$i + 1]
                $i += 1
            }
            Else
            {
                $pos += $arguments[$i]
            }
        }

        return $params
    }
}
