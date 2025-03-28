FROM lscr.io/linuxserver/code-server:4.98.2

RUN sudo apt update
RUN sudo apt install -y \
  build-essential libxtst-dev libpng++-dev libssl-dev pkg-config curl wget \
  vim tig

# This is needed for the PATH line to work
SHELL ["/bin/bash", "-c"]

# Install Golang
ENV GO_VERSION=1.24.1
RUN wget -c https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local/ -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
  rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# Install NVM
ENV BASH_ENV=/config/.bash_env
RUN touch "${BASH_ENV}"
RUN echo '. "${BASH_ENV}"' >> ~/.bashrc
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > .nvmrc
RUN nvm install 22

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN source $HOME/.cargo/env
ENV PATH=$PATH:$HOME/.cargo/bin

# Use 'cache --timeout 900' instead of 'store' to cache git user only for 15 minutes
RUN git config --global credential.helper 'store'
RUN git config --global core.editor "vim"
