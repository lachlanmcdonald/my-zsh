#!/bin/zsh

# Editor
export VISUAL='code'
export EDITOR='code'

# Only process these commands when running an interactive shell
if [[ $- == *i* ]]; then
    CLICOLOR=1

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

    alias mkdir='mkdir -p' # mkdir always creates sub-directories
    alias ls='ls -lAG' # Pretty ls
    alias p='http-server -p 3000 -o -d -i --cors' # Simple HTTP server
    alias inet="ifconfig | grep -E '\d+\.\d+\.\d+\.\d+'" # Quickly get current IPv4 address
    alias dict="code ~/Library/Spelling/LocalDictionary" # Edit local spelling dictionary
    alias fixsound="sudo killall coreaudiod" # Fix sound

    # Git
    alias gs="git status"
    alias gf="git fetch --progress --tags --prune --prune-tags; git pull --progress"
    alias wip="git commit -m WIP"

    # Find files\directories with names that contain the provided string
    function fz() {
        find -E . -iregex ".*$1.*"
    }

    # Delete files that are zero bytes
    function delzb() {
        find . -name '*' -size 0 -delete
    }

    # Prune empty directories
    function empty() {
        find . -type d -empty -delete
    }

    # Poster a video
    function poster() {
        bname=$(basename "$1")
        ffmpeg -i "$1" -vframes 1 -f image2 "${bname%.*}.jpg"
    }

    # Trim an image
    function itrim() {
        convert "$1" -trim +repage "$1"
    }

    # Output a plist file as JSON
    function pj() {
        plutil -convert json -r -o - "$1"
    }

    # Convert an image into a favicon
    function favicon() {
        bname=$(basename "$1")
        magick "$1" -background none -resize 128x128 -density 128x128 "$bname.ico"
    }

    # Recompress images using MozJPEG
    function mozjpeg() {
        for f in *.jpg; do
            if [ -e $f ]; then
                fs1=`stat -f"%z" "$f"`
                /usr/local/opt/mozjpeg/bin/jpegtran -outfile "$f" -optimise -copy none "$f"

                if [ $? -eq 0 ]; then
                    fs2=`stat -f%z "$f"`
                    change=`bc -l <<< "$fs2 / $fs1 * 100"`
                    change=`bc -l <<< "scale=2; $change/1"`
                    echo "$f   $change"
                else
                    echo "Could not process: $f" >&2
                fi
            fi
        done
    }

    # Fix fonts
    function fixfonts() {
        sudo atsutil server -shutdown
        sudo atsutil databases -remove
    }

    # GIF to MP4; brew install ffmpeg
    function gifmov() {
        bname=$(basename "$1")
        ffmpeg -i "$1" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "${bname%.*}.mp4"
    }
fi
