FROM lscr.io/linuxserver/code-server:4.20.0

RUN sudo apt update
RUN sudo apt install -y build-essential vim tig nodejs npm golang

# This is needed for the PATH line to work
SHELL ["/bin/bash", "-c"]

# Cache your git password for 15 minutes, so you don't have to enter it for every push
RUN git config --global credential.helper cache && git config --global core.editor "vim"
