# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

eval "$(starship init bash)"
export TERM=xterm-256color

# bash aliases

alias powermode='sudo auto-cpufreq --force performance'
alias batterymode='sudo auto-cpufreq --force powersave'
alias powerst='sudo auto-cpufreq --force reset'
alias netcp='rsync -avhz --info=progress2'
alias tailup='sudo tailscale up'
alias taildn='sudo tailscale down'
alias myspace='ssh kyrotron@myspace.local -p 22'
alias dnfupd='sudo dnf update'
alias sysup='sudo dnf upgrade --refresh -y && sudo dnf autoremove -y'
alias cp='cp -i'
alias mv='mv -i'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias tree='tree -CAhF --dirsfirst'
alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '
alias text-mode='sudo systemctl set-default multi-user.target'
alias gui-mode='sudo systemctl set-default graphical.target'
alias mnt-hdd='sudo mount /dev/sda1 /HDD/'
alias umnt-hdd='sudo umount /HDD/'
alias cs='cd;ls'
alias homelab='ssh -X root@lab '
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kyrotron/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kyrotron/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kyrotron/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kyrotron/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

eval "$(starship init bash)"
export TERM=xterm-256color

# bash aliases

alias powermode='sudo auto-cpufreq --force performance'
alias batterymode='sudo auto-cpufreq --force powersave'
alias powerst='sudo auto-cpufreq --force reset'
alias netcp='rsync -avhz --info=progress2'
alias tailup='sudo tailscale up'
alias taildn='sudo tailscale down'
alias myspace='ssh kyrotron@myspace.local -p 22'
alias dnfupd='sudo dnf update'
alias sysup='sudo dnf upgrade --refresh -y && sudo dnf autoremove -y'
alias cp='cp -i'
alias mv='mv -i'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias tree='tree -CAhF --dirsfirst'
alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '
alias text-mode='sudo systemctl set-default multi-user.target'
alias gui-mode='sudo systemctl set-default graphical.target'

alias cs='cd;ls'
alias homelab='ssh -X root@lab '
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init bash)"
export TERM=xterm-256color


# # tools alias

# declare -A pomo_options
# pomo_options["work"]="45"
# pomo_options["break"]="10"

# pomodoro () {
#   if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
#   val=$1
#   echo $val | lolcat
#   timer ${pomo_options["$val"]}m
#   spd-say "'$val' session done"
#   fi
# }

# alias wo="pomodoro 'work'"
# alias br="pomodoro 'break'"
