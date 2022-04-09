function k --description "Connect to existing kakoune session or create a new one" --argument-names filename
    if test -n "$filename"
        # Use the working dir of the filename if one was passed
        set -f file_basedir (dirname (realpath $filename))
    else
        # Use the current working directory if there's no filename
        set -f file_basedir (pwd)
    end

    set -l git_toplevel (fish -c "cd $file_basedir && git rev-parse --show-toplevel 2>/dev/null")

    if test -z $git_toplevel
        # Run a disconnected session if not in a git repo
        kak $filename
        return
    end

    set -l projectname (basename $git_toplevel | string replace . -)
    set -l session (kak -l | grep $projectname)

    if test -z "$session"
        # Create a new session if there are none
        kak -s $projectname $filename
    else
        # Otherwise connect to existing session
        kak -c $projectname $filename
    end
end
