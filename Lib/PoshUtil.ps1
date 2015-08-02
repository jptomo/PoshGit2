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


Function Get-FuncParams
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [String]
        $FuncName
    )

    Process
    {
        $funcParams = (Get-Help $FuncName).parameters.parameter
        $defaults = ($funcParams | % { @{$_.name = $_.defaultValue} })

        $keyMaps = @{}
        ForEach($obj in ($funcParams | ? { $_.position -Eq 'named' }))
        {
            $aliases = ($obj.description.Text -Split '\n' `
                        | ? { $_.Trim().StartsWith('alias: ') } `
                        | % { $_.Trim() } `
                        | % { [String]::Join('', $_[7..($_.Length - 1)]) -Split ',' } `
                        | % { $_.Trim() })
            $keyMaps[$obj.name] = $aliases
        }

        $positionals = ($funcParams | ? { $_.position -Match '[0-9]+' } | % { @{$_.name = [Int] $_.position} })

        return $defaults, $keyMaps, $positionals
    }
}


Function Resolve-Args
{
    [CmdletBinding()]
    param(
        [String]$Arguments,
        $Defaults,
        $KeyMaps,
        $Positionals
    )

    Process
    {
        $params = $Defaults

        # Create reverse map of KeyMaps.
        # To Map Arguments.
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

        $pos = 0
        For($i = 0; $i -lt $Arguments.Count; $i += 1)
        {
            If($maps.Keys -contains $Arguments[$i])
            {
                $params[$maps[$Arguments[$i]]] = $Arguments[$i + 1]
                $i += 1
            }
            Else
            {
                If($pos -lt $Positionals.Count)
                {
                    $params[$Positionals[$pos]] = $Arguments[$i]
                }
                $pos += 1
            }
        }

        return $params
    }
}


Function Convert-FullPath
{
    Param
    (
        [string]$Path
    )

    Process
    {
        return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
    }
}


Function Get-RandomText
{
    [CmdletBinding()]
    param(
        [Int] $Length = 24,
        [String] $Choice = 'abcdefghijklmnopqrstuvwxyz0123456789'
    )

    Process
    {
        $Choices = (($Choice -Split '') | ? { $_ -Ne '' })

        $value = ''
        For($i = 0; $i -Lt $Length; ++$i)
        {
            $value += (Get-Random -InputObject $Choices)
        }
        return $value
    }

}


Function New-TempDirectory
{
    [CmdletBinding()]
    param(
        [String] $Prefix = ''
    )

    Process
    {
        Do
        {
            $path = (Join-Path $ENV:TMP "${Prefix}$([IO.Path]::GetRandomFileName())")
        }
        While(Test-Path $path)

        return (New-Item -ItemType Directory $path)
    }
}
