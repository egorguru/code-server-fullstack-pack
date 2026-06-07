FROM lscr.io/linuxserver/code-server:4.123.0

RUN sudo apt update
RUN sudo apt install -y \
  build-essential libxtst-dev libpng++-dev libssl-dev pkg-config curl wget \
  vim tig

# This is needed for the PATH line to work
SHELL ["/bin/bash", "-c"]

# Install Golang
ENV GO_VERSION=1.26.4
RUN wget -c https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local/ -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
  rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_26.x | bash - && apt-get install -y nodejs

# Use 'cache --timeout 900' instead of 'store' to cache git user only for 15 minutes
RUN git config --global credential.helper 'store'
RUN git config --global core.editor "vim"
