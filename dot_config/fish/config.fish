if status is-interactive
    # Commands to run in interactive sessions can go here
    source /usr/share/cachyos-fish-config/cachyos-config.fish

    set -gx EDITOR nvim
    set -gx GPG_TTY (tty)
    set -gx PYTHON_HISTORY /dev/null
    set -gx UV_NO_MANAGED_PYTHON 1

    fish_add_path $HOME/.cargo/bin

    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gca="git commit --amend --reset-author"
    alias gp="git push"
    alias gpf="git push --force-with-lease"
    alias gl="git log"
    alias glo="git log --oneline"
    alias gsw="git switch"
    alias y=yazi
    alias k=kubectl

    function fish_greeting
    end

    functions -e history

    function safeomp
        gopass show -o opencode | read -l key; or return
        set -lx OPENCODE_API_KEY $key
        nono run -p omp --allow . $argv -- omp-proxy
    end

    function safeompc
        gopass show -o opencode | read -l key; or return
        set -lx OPENCODE_API_KEY $key
        nono run -p omp --allow . $argv -- omp-proxy -c
    end

    function hashmail -a name
        set hash (printf "$name" | md5sum | head -c4)
        echo "$name"_"$hash"@mikucat.me
    end
    
    function enforce_ascii_command --on-event fish_preexec
        set -l cmd $argv
    
        if string match -r '[^\x00-\x7F]' -- "$cmd" >/dev/null
            set_color red --bold
            echo "[WARNING] Detected non-ASCII characters"
            set_color normal
            return 1
        end
    end
end
