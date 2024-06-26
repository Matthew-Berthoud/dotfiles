# bash_profile runs on login, bashrc runs when shell opened
os_name=$(uname -s)

if [ "$os_name" = "Darwin" ]; then
    echo ".bash_profile running on Mac."

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/matthewberthoud/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/matthewberthoud/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/matthewberthoud/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/matthewberthoud/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<


    # rust
    . "$HOME/.cargo/env"

    # brew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Added by Toolbox App
    export PATH="$PATH:/Users/matthewberthoud/Library/Application Support/JetBrains/Toolbox/scripts"

    # remove warning about default shell being zsh
    export BASH_SILENCE_DEPRECATION_WARNING=1

else
    echo ".bash_profile running on lab machine"
    export PATH="$PATH:/home/bren/Software/sim/misc/yas"
    export PATH="$PATH:/home/bren/Software/sim/misc/yis"
    export PATH="$PATH:/home/bren/Software/sim/misc"
    export PATH="$PATH:/home/bren/Software/sim/pipe"
    export PATH="$PATH:/home/bren/Software/sim/seq"
fi


# Run this on startup obviously
source ~/.bashrc
