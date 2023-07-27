#!/bin/zsh

# Editor
export VISUAL='code'
export EDITOR='code'

# Only process these commands when running an interactive shell
if [[ $- == *i* ]]; then
	CLICOLOR=1

	# pnpm
	alias pn="pnpm"

	# Hide/show dot files
	alias showdots="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
	alias hidedots="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

	# Hide\show desktop icons
	alias deskoff="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias deskon="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

	# Shortcuts
	alias s='cd ~/Sites/'
	alias d='cd ~/Desktop/'
	alias dw='cd ~/Downloads/'
	alias drop="cd /Volumes/Drop"

	alias mkdir='mkdir -p' # mkdir always creates sub-directories
	alias ls='ls -lAG' # Pretty ls
	alias p='http-server -p 4567 -o -d -i --cors' # Simple HTTP server
	alias inet="ifconfig | grep -E '\d+\.\d+\.\d+\.\d+'" # Quickly get current IPv4 address
	alias dict="code ~/Library/Spelling/LocalDictionary" # Edit local spelling dictionary

	# Git
	alias gs="git status"
	alias gf="git fetch --progress --tags --prune --prune-tags; git pull --progress"
	alias wip="git commit -m WIP"

	# Find files\directories with names that contain the provided string
	function fz() {
		find -E . -iregex ".*$1.*"
	}

	# Delete files that are zero bytes
	# and prune empty directories
	function delzb() {
		find . -type f -name '*' -size 0 -delete
		find . -type d -empty -delete
	}
	
	# Unlock all files
	function unlock() {
		find . -flags uchg -exec chflags nouchg {} \;
	}

	# Fix audio
	function fixaudio() {
		sudo kill -9 `ps ax | grep 'coreaudio[a-z]' | awk '{print $1}'`
	}
fi
