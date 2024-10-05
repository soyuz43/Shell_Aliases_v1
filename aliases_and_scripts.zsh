# * --------------------------------------------------------------------------------
# ! Personal Aliases and Scripts Configuration
# * --------------------------------------------------------------------------------

# * --------------------
# ? Shell Enhancements
# * --------------------
# Search command history for specific keywords
alias h="history | grep"
# Open editor in '.' 
alias cdc="cd && c && cd -"
#<|!|>#

# * --------------------
# ? Filesystem Operations
# * --------------------
#Alias for 'exa' command:list files and directories in a long format with icons, one column, and directories grouped first
alias ls="exa -lbhF --header --icons --group-directories-first"
#Alias for 'exa' command:list files and directories in a long format, sorted by name, with icons and human-readable file sizes
alias lsn="exa -lbhF --icons --sort=.name"
#Alias for 'exa' command:list directories only, with icons
alias l="exa -1 --icons --only-dirs"
#Alias for 'exa' command:long format list with icons and headers
alias ll="exa --long --header --icons"
#Alias for 'exa' command:detailed list with all files, icons, and color
alias la="exa -alh --time-style=long-iso --color-scale --icons"
# Tree view of directory structure
alias tree="exa --tree"
# Tree view up to 2 levels deep
alias lt="exa --tree --level=2"
# Tree view up to 3 levels deep
alias lt3="exa --tree --level=3"
# Tree view up to 4 levels deep
alias lt4="exa --tree --level=4"
# Navigate up one directory level and list contents
alias cdl='cd .. && ls'
# Navigate up one directory level and list contents in tree format
alias cdlt='cd .. && lt'
# Tree view limited to directories, 2 levels deep
alias ltf='exa --tree --level=2 --only-dirs'
# Tree view limited to directories, 3 levels deep
alias ltf3='exa --tree --level=3 --only-dirs'
#<|!|>#

# * --------------------
# ? Navigation and File Management
# * --------------------
# Copies the realpath of the current directory to clipboard
alias path='realpath "${1:-.}" | clip.exe'
# Copies the present working directory to clipboard
alias cpwd="pwd | clip.exe"

# Opens the current directory in Windows Explorer (shortcut)
alias win="explorer.exe ."
# Prints relative paths of files in a directory or current directory if no argument is provided
# File Search: initializes an fzf search in the local directory and downstream directories, including hidden files
# Usage:
# fs - search for files in the current directory and downstream directories
# fs /path/to/directory - search for files in a specific directory and its downstream directories
# fs <search_query> - search for files containing the specified search query
alias fs='
  local directory="${1:-.}"
  find "$directory" -type f -printf "%P\n" | fzf +m --query="$1"
'
# File Paths: prints relative paths of files in a directory or current directory if no argument is provided
# Usage:
# fp - print relative paths of files in the current directory
# fp /path/to/directory - print relative paths of files in a specific directory
alias fp='
  local directory="${1:-.}"
  find "$directory" -type f -printf "%P\n"
'
# File Paths Absolute: prints real paths of files in a directory or current directory if no argument is provided
# Usage:
# fpa - print real paths of files in the current directory
# fpa /path/to/directory - print real paths of files in a specific directory
alias fpa='
  local directory="${1:-.}"
  find "$(realpath "$directory")" -type f -printf "%p\n"
'
# Finds a file and open it with Visual Studio Code
# Usage: fnd <search_query>
alias c='
fd() {
  local dir=$(find . -type d -printf "%P\n" | fzf +m --query="$PWD/$1") # Search for directories, prefill with $PWD
  if [ -n "$dir" ]; then # If a directory is selected
    code "$dir" --folder-uri="file://$(pwd)" || echo "Failed to open the directory in Visual Studio Code"
  else
    echo "No matching directory found" # If no directory is selected
  fi
}

'
# Alias: cdd
# Description: Quickly change to a directory by searching with fzf
# Usage: cdd <search_query>
alias cdd='
  local dir=$(find ~ -type d -printf "%P\n" | fzf +m --query="$1")
  cd "$dir" || echo "No matching directory found"
'
# Alias: psg
# Description: Search for a process and kill it
# Usage: psg <search_query>
alias psg='
  local pid=$(ps aux | grep -i "$1" | awk "{print \$2}")
  kill -9 "$pid" || echo "No matching process found"
'
# Alias: fndc
# Description: Find and open a directory using fzf
# Usage: fndc [search_query]
# 
# If no search query is provided, opens a fzf search interface to select a directory
# If a search query is provided, searches for directories with the given name
# Opens the selected directory (or the parent directory of the selected file) in the default file manager
alias fncd='
  if [ -z "$1" ]; then
    dir=$(find . -type d -printf "%P\n" | fzf +m) || return
    xdg-open "$dir"
  else
    dir=$(find . -type d -name "$1" -printf "%P\n" | fzf +m) || return
    xdg-open "$dir"
  fi
'

simpnav() {
  if [ "$1" = "+" ]; then
    pushd "$2" > /dev/null
  elif [ "$1" = "-" ]; then
    popd > /dev/null
  elif [ "$1" = "ls" ]; then
    dirs -v
  elif [ "$1" = "clear" ]; then
    dirs -c
  else
    pushd "$1" > /dev/null
  fi
}
alias filenav-disp='cat /home/copin43/personal/Utilities/MyBashScripts/config/aliases_and_scripts.zsh | sed -n "/# ? Navigation and File Management/,/#<|!|>#/p"'

#<|!|>#
# * --------------------
# ? System Utilities
# * --------------------
# Displays Linux distribution information and Displays system messages
alias sysinfo="lsb_release -a && dmesg"
# Fuzzy search manual pages
alias fman="man -k . | fzf --preview 'man {1} | col -bx' | awk '{print $1}' | xargs man"
# Fuzzy search from '/' (Note: SLOW)
alias search_0="find / -type f 2>/dev/null | fzf | xargs -I {} echo "Selected path: {}""
# Display an animated ASCII art parrot
alias parrot="curl parrot.live"
# Display CPU information in a readable format, with fuzzy searching
alias cpuinfo="cat /proc/cpuinfo | grep -v '^#' | fzf"
# Display memory information in a human-readable format, with fuzzy searching
alias meminfo="free -m | fzf"
# Display disk usage information in a human-readable format, with fuzzy searching
alias diskinfo="df -h | fzf"
# Display network interface information, with fuzzy searching
alias netinfo="ip a | fzf"
# Display the system uptime in a more human-readable format
alias uptime="uptime --pretty"
# Alias: ports
# Description: List currently used ports
# Usage: ports
alias ports='ss -tlnp | fzf'
#<|!|>#
# * --------------------
# ? Development Tools
# * --------------------
# Clears the terminal screen
alias cl="clear"
# Opens the current directory in Codiumfzf
alias c.="code ."
#<|!|>#
# * --------------------
# ? Git Commands
# * --------------------

# Initializes a new git repository
alias ginit="git init"
# Checks out a git branch
alias gch="git checkout"
# Checks out the main branch
alias gchm="git checkout main"
# Adds all changes to staging area
alias gadd="git add ."
# Restores the working directory files
alias gresta="git restore ."
# Retrieves the URL of the remote origin
alias gurl="git config --get remote.origin.url"
# Decorated git log
alias gt="git log --graph --decorate --all --pretty=format:'%C(auto)%h %d %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"


## ! Git Status Porcelain Aliases

# Usage examples:
# - gspor: Run the alias to see the git status with key labels
# - gspor | grep X: M: Find files with modified index and working directory
# - gspor | grep Y: A: Find files added to the working directory
# - gspor | grep X: D: Find files deleted from the index"
alias gspor="git status --porcelain | sed -e 's/^/  /' -e 's/^[^ ]* /X: /' -e 's/^[^ ]*  /Y: /'"
alias gs="git_status"

function git_status {
  if [ "$#" -eq 1 ]; then
    choice="$1"
  else
    echo "Choose a view:"
    echo "1. Normal git-status view"
    echo "2. --porcelain view with key"
    read -r choice
  fi

  # Use a case statement to handle the user's choice
  case $choice in
    1) 
      # Option 1: Normal git-status view
      git status
      ;;

    2) 
      # Option 2: --porcelain view with key
      git status --porcelain | sed -e 's/^/  /' -e 's/^[^ ]* /X: /' -e 's/^[^ ]*  /Y: /'
      ;;

    *) 
      # Invalid choice: print an error message and return 1
      echo "Invalid choice"
      return 1
      ;;
  esac
}

### Git Status Enhancements Aliases ###
# Normal git-status view
alias gsnormal="git status"

# Porcelain view with key for modified files
alias gsmodify="git status --porcelain | grep '^M' | cut -c 4-"

# Porcelain view with key for added files
alias gsadd="git status --porcelain | grep '^A' | cut -c 4-"

# Porcelain view with key for deleted files
alias gsdel="git status --porcelain | grep '^D' | cut -c 4-"

# Porcelain view with key for unmerged files
alias gsunmer="git status --porcelain | grep '^U' | cut -c 4-"

# Porcelain view with key for renamed files
alias gsr="git status --porcelain | grep '^R' | cut -c 4-"

# Count number of changes
alias gscount="git status --porcelain | wc -l"

# Show diff for modified files
alias gsdiff="git status --porcelain | grep '^M' | cut -c 4- | xargs git diff"

# List all files with changes
alias gsfiles="git status --porcelain | cut -c 4- | xargs"

#<|!|>#
# * --------------------
# ? Networking
# * --------------------
# Clears the terminal and starts JSON server on port 8088
alias jserve="cl && json-server -p 8088 database.json"
# Runs development server for React applications
alias sasa="npm run dev"
#Fix for CSS nonsense
alias rserve="while true; do npm run dev & PID=\$!; echo 'Started npm with PID \$PID'; sleep 60; ps -p \$PID -o pid,cmd; kill -9 -\$PID; sleep 2; done"
# ""
alias rserve30="while true; do npm run dev & PID=\$!; echo 'Started npm with PID \$PID'; sleep 30; ps -p \$PID -o pid,cmd; kill -9 -\$PID; sleep 2; done"
# ""
alias rserve15="while true; do npm run dev & PID=\$!; echo 'Started npm with PID \$PID'; sleep 15; ps -p \$PID -o pid,cmd; kill -9 -\$PID; sleep 2; done"
#<|!|>#
# * --------------------
# ? Python Specific
# * --------------------
# Sets the default Python interpreter path
# alias python="/usr/bin/python3"
# Runs a specific Docker container for a Python environment
# alias dolph="ollama run tinydolphin:1.1b-v2.8-fp16"
# Shorten python to 'pyth' when invoking files
# alias pyth="python"
#<|!|>#
# * --------------------
# ? Tmux
# * --------------------
# List Sessions
alias tls='tmux list-sessions'
# List Sessions
alias tli='tmux list-sessions'
# Create a new tmux session
alias tnew='tmux new-session -s'
# Attach to an existing tmux session
alias tatt='tmux attach-session -t'
# Detach from the current tmux session
alias tdet='tmux detach'
# Kill a specific tmux session
alias tkill='tmux kill-server'
# Rename the current tmux session
alias tren='tmux rename-session -t'
# List all tmux windows in the current session
alias tlw='tmux list-windows'
# Switch to a specific tmux window
alias tsw='tmux select-window -t'
# Create a new window in the current tmux session
alias tneww='tmux new-window'
# Split the current pane horizontally
alias tsplit='tmux split-window -h'
# Split the current pane vertically
alias tsplitv='tmux split-window -v'
# Navigate to the next pane
alias tnextp='tmux select-pane -t :.+'
# Navigate to the previous pane
alias tprevp='tmux select-pane -t :.-'
# Resize panes (example usage commented out)
# Usage: tresize -D 10 (to resize the current pane down by 10 units)
alias tresize='tmux resize-pane'
#<|!|>#
# * --------------------
# ? Echo Aliases
# * --------------------
# * --------------------

#  --------------------------------------------------------------------------------
## # ! Personal Scripts Configuration
#  --------------------------------------------------------------------------------

# * --------------------
# ? File Management Scripts
# * --------------------


#<|!|>#
# * --------------------
# ? Hardware Monitoring Scripts
# * --------------------
# Monitor system statistics
alias monitor="/home/copin43/personal/Utilities/MyBashScripts/tools/hardware/sys_mon.sh"
# Alias for system monitor
alias mon="/home/copin43/personal/Utilities/MyBashScripts/tools/hardware"
#  --------------------------------------------------------------------------------
## # ! Personal Scripts Configuration
#  --------------------------------------------------------------------------------

# * --------------------
# ? File Management Scripts
# * --------------------
# Navigate to a directory selected via fuzzy search
fcd() {
  local dir
  dir=$(find /home/copin43/personal/Utilities/{MyBashScripts,personal,vaults,workspace} -type d! -path '*/.*' 2>/dev/null | fzf)
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

alias lk="kl"
# Log output wrapper
alias dumplog="/home/copin43/personal/Utilities/MyBashScripts/tools/fileManagement/dump-output_wrapper.sh"
# Lists all directories
alias dirs="/home/copin43/personal/Utilities/MyBashScripts/tools/displayPaths/list_dirs.sh"
# Lists all files
alias f="/home/copin43/personal/Utilities/MyBashScripts/tools/displayPaths/list_files.sh"
# Create JS files in current directory
alias jstree="/home/copin43/personal/Utilities/MyBashScripts/tools/fileManagement/create_js_files_current_dir.sh"
# Set up a new web project environment
alias fulltree="/home/copin43/personal/Utilities/MyBashScripts/tools/fileManagement/web-project-env.sh"
# Backup files and create links
alias backup="/home/copin43/personal/Utilities/MyBashScripts/tools/fileManagement/backup_and_link.sh"
#<|!|>#
# * --------------------
# ? Hardware Monitoring Scripts
# * --------------------
# Monitor system statistics
alias monitor="/home/copin43/personal/Utilities/MyBashScripts/tools/hardware/sys_mon.sh"
# Alias for system monitor
alias mon="/home/copin43/personal/Utilities/MyBashScripts/tools/hardware/sys_mon.sh"
# Kernel activity monitor
alias kernel="/home/copin43/personal/Utilities/MyBashScripts/tools/hardware/kernel-mon.sh"
#<|!|>#
# * --------------------
# ? Networking Scripts
# * --------------------
# Start server with tmux splits for better multitasking
alias server="/home/copin43/personal/Utilities/MyBashScripts/scripts/network/run-api-script/setup_dev_environment.sh"
alias tser="/home/copin43/personal/Utilities/MyBashScripts/scripts/network/run-api-script/setup_dev_environment.sh"
# Alias for the tmux server setup
alias fullserve="/home/copin43/personal/Utilities/MyBashScripts/tools/Network/tmux_server_create_splits.sh"
#<|!|>#
# * --------------------
# ? Git Management Scripts
# * --------------------
# List all git branches on one line
alias gall="/home/copin43/personal/Utilities/MyBashScripts/scripts/tools/git/git-list-branches-oneline.sh"
# Alias for listing all git branches
alias gb="/home/copin43/personal/Utilities/MyBashScripts/scripts/tools/git/git-list-branches-oneline.sh"
# Display git branch creation dates
alias gcrd="/home/copin43/personal/Utilities/MyBashScripts/scripts/tools/git/git_branch_creation_dates.sh"
# Display git reflog in a concise one-line format
alias gref="/home/copin43/personal/Utilities/MyBashScripts/scripts/tools/git/git_reflog_oneline.sh"
# Pull changes from origin main
alias gpom="/home/copin43/personal/Utilities/MyBashScripts/scripts/tools/git/git_pull_origin_main.sh"
#<|!|>#
# * --------------------
# ? General Utility Scripts
# * --------------------
# Generate README files
alias generate="/home/copin43/RIG/proving-grounds/ci/build_scripts/concat_Presets_v01.sh"


# Dump with Options
alias dwo="/home/copin43/personal/Utilities/MyBashScripts/scripts/tools/dump-with-options/dump_with_options.sh"



#<|!|>#

# * --------------------------------------------------
# ? Utility Functions and Pipes
# * --------------------------------------------------
# Search and color-highlight aliases in configuration files
find_alias() {
    # Filter aliases before coloring, based on input characters
    pre_color_filter() {
        grep "^[[:space:]]*alias" "$1" | grep -v "^[[:space:]]*#" | \
        awk -v pat="$2" '$0 ~ pat { print $0 }'
    }
    # Apply color to the alias name
    apply_color() {
        sed 's/\(alias \)\([^=]*\)=\(.*\)/\1\x1b[38;5;214m\2\x1b[0m=\3/'
    }
    # Combine and sort the alias definitions from the sources
    combined_aliases=$( { 
        pre_color_filter ~/.zshrc "$1";
        pre_color_filter /home/copin43/personal/Utilities/MyBashScripts/config/aliases_and_scripts.zsh "$1";
    } | sort )
    # Apply color after filtering
    echo "\n$combined_aliases" | apply_color
}
alias kalias="find_alias"
alias fa="find_alias"
# End of Personal Aliases and Scripts Configuration
# --------------------------------------------------
#<|!|>#

