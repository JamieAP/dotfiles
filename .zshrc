export ZSH=/usr/share/oh-my-zsh

ZSH_THEME="ys"

plugins=(
  git aws history
)

source $ZSH/oh-my-zsh.sh

export LANG=en_GB.UTF-8
export EDITOR='vim'

export NODE_MODULES=$HOME/.node_modules
export GOPATH=$HOME/dev/go

PATH=/usr/local/sbin:/usr/local/bin:/usr/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$NODE_MODULES/bin

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

k8s_info='$fg[cyan]`grep current ~/.kube/config | cut -d " " -f 2`'

PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${git_info} \
${k8s_info} \
%{$fg[cyan]%}%* $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"

# funcs
kgp() {
  normal="$(tput sgr0)"
  red="$(tput setaf 1)"
  green="$(tput setaf 2)"
  yellow="$(tput setaf 3)"

  kubectl get pods "$@" \
    | sed "s/Running/${green}Running${normal}/g" \
    | sed "s/Pending/${yellow}Pending${normal}/g" \
    | sed "s/Completed/${blue}Completed${normal}/g" \
    | sed "s/Error/${red}Error${normal}/g" \
    | sed "s/CrashLoopBackOff/${red}CrashLoopBackOff${normal}/g"
}

fs() {
  du -h --max-depth=1 "$@" | sort -hr
}

klogs() {
  kgp | grep $1 | awk '{print $1}' | head -n 1 | xargs -t -I {} kubectl logs -f {} $2
}

# aliases
alias gm="git commit -m"
alias gs="git status -s"
alias gd="git diff"
alias gma="git commit --amend"
alias gppf="git push --force-with-lease"
alias gfr="git fetch origin master && git rebase origin/master"
alias k8s="cd ~/dev/kubernetes-manifests"
alias tf="cd ~/dev/terraform"
alias godir="cd ~/dev/go/src/github.com"
alias k="kubectl"
alias vi=vim
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias ls=exa
alias ll="exa -la"
alias ys="yaourt -S"
alias yupdate='yaourt -Syu'
alias yclean='yaourt -Rsn $(yaourt -Qdtq)'
alias kgpans="kgp --all-namespaces"
alias treel="tree | less"
alias unextend="xrandr --output eDP1 --auto --pos 0x0"
alias extendleft="xrandr --output eDP1 --auto --pos 3840x0 --output HDMI3 --scale 2x2 --auto --pos 0x0 --fb 6720x3960"
alias extendup="xrandr --output eDP1 --auto --pos 0x2160 --output HDMI3 --scale 2x2 --auto --pos 0x0 --fb 6720x3960"
