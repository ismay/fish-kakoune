function kc --wraps kak --description "Connect to existing kakoune session or create a new one"
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1
    or ! git rev-parse --show-toplevel >/dev/null 2>&1

    # If git toplevel can't be found, run a disconnected session
    kak $argv
    return
  end

  set -l dirname (git rev-parse --show-toplevel)
  set -l projectname (basename $dirname | string replace . -)
  set -l session (kak -l | grep $projectname)

  if test -z "$session"
    # Create a new session if there are none
    kak -s $projectname $argv
  else
    # Otherwise connect to existing session
    kak -c $projectname $argv
  end
end
