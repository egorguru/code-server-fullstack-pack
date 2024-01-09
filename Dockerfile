FROM lscr.io/linuxserver/code-server:4.20.0

RUN sudo apt update
RUN sudo apt install -y \
  build-essential libxtst-dev libpng++-dev curl \
  vim tig nodejs npm golang

# This is needed for the PATH line to work
SHELL ["/bin/bash", "-c"]

# Use 'cache --timeout 900' instead of 'store' to cache git user only for 15 minutes
RUN git config --global credential.helper 'store' && git config --global core.editor "vim"
