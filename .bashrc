os_name=$(uname -s)
if [ "$os_name" = "Darwin" ]; then
    echo ".bashrc running on Mac"

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

    # no hostname on local machine, just current dir
    PS1="(\W) "
else
    # lab machines
    echo ".bashrc running on lab machine"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
            . "/opt/anaconda/etc/profile.d/conda.sh"
        else
            export PATH="/opt/anaconda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    export PATH="/home/bren/Software/sim/misc/yas:$PATH"
    export PATH="/home/bren/Software/sim/misc/yis:$PATH"

    # show hostname when on linux machines
    PS1="\h(\W) "
fi

# vim mode for terminal
set -o vi

# Most of my aliases (more at bottom)
alias e="exit"
alias c="clear"

alias ch="open -a Google\ Chrome"
alias lt="latexmk -pdf -pvc"

alias dot="cd ~/dotfiles"
alias dt="cd ~/Desktop"
alias sb="cd ~/Desktop/second_brain"
alias dl="cd ~/Downloads"
alias dc="cd ~/Documents"
alias ..="cd .."

alias ls="ls --color=auto"
alias la="ls -lah"
alias lg="la | grep"

alias t=tmux
alias v=vim
alias vr="v ~/.vimrc"
alias br="v ~/.bashrc"
alias bp="v ~/.bash_profile"
alias re="source ~/.bashrc"

alias g=git
alias gl="git pull"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

# Use this to randomly select a machine, hopefully a fast one
# For all other ssh stuff use Host names in .ssh/config
sshlab () {
    ssh mwberthoud@th121-$((1 + RANDOM % 24)).cs.wm.edu
}

econ () {
    cd /Users/matthewberthoud/Documents/ECON_$1/
    pwd
}

cs () {
    cd ~/cs/$1
    pwd
}

hw () {
    cd ~/cs/$1/hw/$2/
    if [ -d "repo" ]; then
        cd repo
    fi
    pwd
}

notes () {
    if [ "$1" = "461" ]; then
        econ $1
    else
        cs $1
    fi
    if [ -d "notes" ]; then
        cd notes
        pwd
    fi
    if [ -f "notes.md" ]; then
        v notes.md
    fi
}

docs () {
    case $1 in
        sh | bash) ch https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html;;
        *) echo No documentation linked for $1;;
    esac
}

lazygit() {
    gs
    echo
    echo "********** GIT PULL **********"
    gl
    gs
    echo
    echo "********** GIT ADD ***********"
    ga 
    gs
    echo
    echo "********* GIT COMMIT *********"
    gc "$1"
    gs
    echo
    echo "********** GIT PUSH **********"
    gp
    gs
}

# personalized help function that shows my notes
h() {
    case $1 in
        git | g) case $2 in 
            branch) 
                echo "New branch:    g checkout -b <name>"
                echo "               g branch <name> (doesn't switch to it)"
                echo "First push:    g push -u origin"
            ;;
            *)  echo "Specify an option: branch, etc.";;
        esac ;;
        *) echo No helpdoc written for $1;;
    esac

}

# move only image on desktop to current directory
img() {
    desktop="~/Desktop"
    img_names=$(find ~/Desktop -maxdepth 1 -type f -name "*.png")
    # expand this reg exp eventually to consider more filetypes
    img_count=$("$img_names" | wc -l)
    if [ "$img_count" -eq 1 ]; then
        echo Moving image $(img_names) to $(pwd)
    elif [ "$count" -eq 0 ]; then
        echo "There are no images on Desktop." 
        return
    else
        echo "There are $(count) images on Desktop. Aborting."
        return
    fi

    directory="."
    files=$(ls "$directory")
    
    # Initialize variables to store the highest number
    highest_number=0
    
    # Loop through each file
    for file in $files; do
        # Check if the file starts with "img-" followed by a number and has a file extension
        if [[ $file =~ ^img-([0-9]+)\..+$ ]]; then
            number="${BASH_REMATCH[1]}"
            # Compare the number with the highest_number
            if (( number > highest_number )); then
                highest_number=$number
            fi
        fi
    done

    new_num=$highest_number + 1
    # update this with more than png when you need to
    mv "$img_names" "$directory/img-$new_num.png"
}
alias ss="mv ~/Desktop/Screen* ./"


# Aliases for functions defined above
alias lazy="lazygit"

