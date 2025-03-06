FROM lscr.io/linuxserver/code-server:4.97.2

RUN sudo apt update
RUN sudo apt install -y \
  build-essential libxtst-dev libpng++-dev curl wget \
  vim tig nodejs npm

# This is needed for the PATH line to work
SHELL ["/bin/bash", "-c"]

# Install Golang
RUN wget -c https://go.dev/dl/go1.24.1.linux-amd64.tar.gz && \
  tar -C /usr/local/ -xzf go1.24.1.linux-amd64.tar.gz && \
  rm go1.24.1.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin

# Use 'cache --timeout 900' instead of 'store' to cache git user only for 15 minutes
RUN git config --global credential.helper 'store'
RUN git config --global core.editor "vim"
