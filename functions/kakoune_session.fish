function kakoune_session --description "Get session name from filename" --argument-names filename
    if test -n "$filename"
        # Use the working dir of the filename if one was passed
        set -f file_basedir (dirname (realpath $filename))
    else
        # Use the current working directory if there's no filename
        set -f file_basedir (pwd)
    end

    set -l git_toplevel (fish -c "cd $file_basedir && git rev-parse --show-toplevel 2>/dev/null")

    if test -z $git_toplevel
        # Echo the basename of the target folder if not in git repo
        echo (basename $file_basedir | string replace . - | string replace / root)
        return
    end

    # Echo the name of the folder at the git root
    echo (basename $git_toplevel | string replace . - | string replace / root)
end
