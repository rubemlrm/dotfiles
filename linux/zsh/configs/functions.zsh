function tSession
{
    tmux has-session -t dev 2 >/dev/null
    if [ "$?" -eq 1 ]; then
        echo "No session found. Creating"
        tmux source-file ~/.config/tmux/configs/dev
    else
        echo "session found . connecting"
    fi
    tmux attach-session -t dev

}

# create directory and enter on it
function mkdcd () {
    mkdir -p "$1" && cd "$1"
 }

 # Docker Functions
clear_containers() {
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
}

clear_images() {
	docker rmi -f $(docker images -a -q)
}
