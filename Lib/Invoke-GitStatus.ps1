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
                    # The file doesn't exist.
                    'Nonexistent'          { Return '??' }
                    # The file hasn't been modified.
                    'Unaltered'            { Return '' }
                    # New file has been added to the Index. It's unknown from the Head.
                    # Obsolete -> NewInIndex
                    'Added'                { Return 'A ' }
                    # New file has been added to the Index. It's unknown from the Head.
                    'NewInIndex'           { Return 'A ' }
                    # New version of a file has been added to the Index. A previous version exists in the Head.
                    # Obsolete -> ModifiedInIndex
                    'Staged'               { Return 'M ' }
                    # New version of a file has been added to the Index. A previous version exists in the Head.
                    'ModifiedInIndex'      { Return 'M ' }
                    # The deletion of a file has been promoted from the working directory to the Index. A previous version exists in the Head.
                    # Obsolete -> DeletedFromIndex
                    'Removed'              { Return 'D ' }
                    # The deletion of a file has been promoted from the working directory to the Index. A previous version exists in the Head.
                    'DeletedFromIndex'     { Return 'D ' }
                    # The renaming of a file has been promoted from the working directory to the Index. A previous version exists in the Head.
                    'RenamedInIndex'       { Return '' }
                    # A change in type for a file has been promoted from the working directory to the Index. A previous version exists in the Head.
                    # Obsolete -> TypeChangeInIndex
                    'StagedTypeChange'     { Return '' }
                    # A change in type for a file has been promoted from the working directory to the Index. A previous version exists in the Head.
                    'TypeChangeInIndex'    { Return '' }
                    # New file in the working directory, unknown from the Index and the Head.
                    # Obsolete -> NewInWorkdir
                    'Untracked'            { Return '' }
                    # New file in the working directory, unknown from the Index and the Head.
                    'NewInWorkdir'         { Return ' A' }
                    # The file has been updated in the working directory. A previous version exists in the Index.
                    # Obsolete -> ModifiedInWorkdir
                    'Modified'             { Return ' M' }
                    # The file has been updated in the working directory. A previous version exists in the Index.
                    'ModifiedInWorkdir'    { Return ' M' }
                    # The file has been deleted from the working directory. A previous version exists in the Index.
                    # Obsolete -> DeletedFromWorkdir
                    'Missing'              { Return '' }
                    # The file has been deleted from the working directory. A previous version exists in the Index.
                    'DeletedFromWorkdir'   { Return '' }
                    # The file type has been changed in the working directory. A previous version exists in the Index.
                    # Obsolete -> TypeChangeInWorkdir
                    'TypeChanged'          { Return '' }
                    # The file type has been changed in the working directory. A previous version exists in the Index.
                    'TypeChangeInWorkdir'  { Return '' }
                    # The file has been renamed in the working directory.  The previous version at the previous name exists in the Index.
                    'RenamedInWorkdir'     { Return '' }
                    # The file is unreadable in the working directory.
                    'Unreadable'           { Return '' }
                    # The file is NewInWorkdir but its name and/or path matches an exclude pattern in a <c>gitignore</c> file.
                    'Ignored'              { Return '' }
                    # The file is Conflicted due to a merge.
                    'Conflicted'           { Return 'R ' }
                    default                { Return $item.state.ToString() }
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
