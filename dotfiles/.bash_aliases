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