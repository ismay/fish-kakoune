function k --description "Connect to existing kakoune session or create a new one" --argument-names filename
    set -l session (kakoune_session $filename)
    set -l match (kak -l | grep $session)

    if test -z "$match"
        # Create a new session if there is no match
        kak -s $session $filename
    else
        # Otherwise connect to existing session
        kak -c $session $filename
    end
end
