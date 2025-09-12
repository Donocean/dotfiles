# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

current_os=$(uname)
# fix color bug on wsl2 in window
export COLORTERM=truecolor
export TERM=screen-256color

alias condaac="conda activate"
alias condade="conda deactivate"

# vim mode in terminal
set -o vi

# alias
alias ..="cd .."
alias vi="nvim"

# esp
alias ii=idf.py
alias gidf='. $HOME/esp/esp-idf/export.sh'
alias gadf='. $HOME/esp/esp-adf/export.sh'
# ros2
alias gros='source /opt/ros/humble/setup.zsh'

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p $HOME/.zinit && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
	  print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
	  print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1 atload"!source ~/.theme.zsh" lucid nocd
zinit light romkatv/powerlevel10k

# Plugins
zinit ice depth=1 wait lucid
zinit light Aloxaf/fzf-tab

zinit ice depth=1 wait blockf lucid atpull"zinit creinstall -q ."
zinit light clarketm/zsh-completions

zinit ice depth=1 wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth=1 wait lucid compile"{src/*.zsh,src/strategies/*.zsh}" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice depth=1 wait"2" lucid
zinit light hlissner/zsh-autopair

# open file with vim
v() {
    # check fd name
    local fd_cmd
    if command -v fd &>/dev/null; then
        fd_cmd="fd"
    elif command -v fdfind &>/dev/null; then
        fd_cmd="fdfind"
    else
        echo "Error: 'fd' or 'fdfind' not found. Install fd-find." >&2
        return 1
    fi

    # [--type f] means file
    export FZF_DEFAULT_COMMAND="$fd_cmd --type f --hidden --follow --exclude .git"

    local file=$(fzf)
    if [[ -n "$file" ]]; then
        vi "$file"
    fi
}

# fuzzy cd
c() {
    # check fd name
    local fd_cmd
    if command -v fd &>/dev/null; then
        fd_cmd="fd"
    elif command -v fdfind &>/dev/null; then
        fd_cmd="fdfind"
    else
        echo "Error: 'fd' or 'fdfind' not found. Install fd-find." >&2
        return 1
    fi

    # [--type d] means directories
    export FZF_DEFAULT_COMMAND="$fd_cmd --type d --hidden --follow --exclude .git"

    local path=$(fzf)
    if [[ -n "$path" ]]; then
        cd "$path"
    fi
}

# fuzzy search string
fs() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  file=$(rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}")
  [[ -n "$file" ]] && nvim "$file"
}

# set proxy
function proxy() {
  # export http_proxy=socks5://127.0.0.1:8888
  # export https_proxy=socks5://127.0.0.1:8888
  # export ALL_PROXY=socks5://127.0.0.1:8888

  export http_proxy=http://192.168.2.165:7897
  export https_proxy=http://192.168.2.165:7897
  git config --global http.proxy $http_proxy
  git config --global https.proxy $https_proxy
  echo -e "\e[32mProxy has been successfully set.\e[0m"
}

# unset
function unproxy() {
  unset http_proxy
  unset https_proxy
  unset ALL_PROXY

  git config --global --unset http.proxy
  git config --global --unset https.proxy
  echo -e "\e[31mProxy has been unset.\e[0m"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# check wether current os is MacOS
if [ "$current_os" = "Darwin" ]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/don/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/don/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/don/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/don/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
else
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/don/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/don/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/don/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/don/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    alias open="xdg-open ."
fi

# ros2
if [ -f /usr/share/colcon_cd/function/colcon_cd.sh ]; then
    # if exist，source file
    source /usr/share/colcon_cd/function/colcon_cd.sh
    export _colcon_cd_root=/opt/ros/humble/

    # ros2
    source /opt/ros/humble/setup.zsh
    export ros_workspace_source=install

    alias rcd='colcon_cd'
    alias rmsg='ros2 msg'
    alias rr='ros2 run'
    alias rn='ros2 node'
    alias rt='ros2 topic'
    alias rl='ros2 launch'
    alias rp='ros2 param'
    alias rs='ros2 service'
    alias rpkg='ros2 pkg'
elif [ -f /opt/ros/noetic/setup.zsh ]; then
    source /opt/ros/noetic/setup.zsh
    export ros_workspace_source=devel

    export ROS_HOSTNAME=localhost
    export ROS_MASTER_URI=http://localhost:11311

    # gpu support for gazebo-classic
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
fi

# quick ssh connecting. for connecting OrangePi.
cpi() {
    if [ -z "$1" ]; then
        echo "请输入IP!\n如IP: 192.168.1.100\n输入:\e[31m cpi 1.100\e[0m "
        return 1
    fi

    # 设置终端类型
    export TERM=xterm

    # 执行 SSH 命令
    ssh orangepi@192.168."$1"
}

export PLANNER_DIR=$HOME/my_planner
export PX4_DIR=$HOME/PX4-Autopilot
alias sp="source $PLANNER_DIR/$ros_workspace_source/setup.zsh"
alias pp="cd $PLANNER_DIR"

function pxsim() {
    # run this after you move the "[$PX4_DIR/Tools/simulation/gazebo-classic/sitl_gazebo-classic/models/D435i/lib/*.so]" file to the [$PX4_DIR/build/px4_sitl_default]
    source $PX4_DIR/Tools/simulation/gazebo-classic/setup_gazebo.bash $PX4_DIR $PX4_DIR/build/px4_sitl_default
    export ROS_PACKAGE_PATH="$PX4_DIR:$ROS_PACKAGE_PATH"
    export ROS_PACKAGE_PATH="$PX4_DIR/Tools/simulation/gazebo-classic/sitl_gazebo-classic:$ROS_PACKAGE_PATH"
}

if [ "$current_os" = "Darwin" ]; then
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:"$HOME/quadrotors_control/acados/lib"
    export ACADOS_SOURCE_DIR="$HOME/quadrotors_control/acados/"
fi
export PATH="$HOME/.local/bin/:$PATH"

vf() {
    # 使用 --choose-dir - 参数运行 vifm，它会在退出时将当前目录打印到标准输出
    local dir
    dir="$(vifm . --choose-dir - "$@")"

    # 检查 "dir" 是否是一个有效的、存在的目录
    if [ -n "$dir" ] && [ -d "$dir" ]; then
        # 如果是，就 cd 过去
        cd "$dir"
    fi
}
