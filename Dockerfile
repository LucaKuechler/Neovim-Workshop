FROM debian:latest

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y unzip \
                       pip \
                       curl \
                       wget \
                       tmux \
                       xclip \
                       net-tools \
                       sudo \
                       ripgrep \
                       npm \
                       ninja-build \
                       gettext \
                       libtool \
                       libtool-bin \
                       autoconf \
                       automake \
                       cmake \
                       g++ \
                       pkg-config \
                       doxygen \
                       black

# INSTALL NODE JS
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
RUN sudo bash /tmp/nodesource_setup.sh
RUN sudo apt install -y nodejs

# INSTALL NEOVIM
COPY ./neovim /neovim
RUN cd /neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
# RUN make install

# INSTALL LOCALES
RUN apt-get install -y locales && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

# FIX PYHTON LINK
RUN ln -s /usr/bin/python3 /usr/bin/python

# DEACTIVATE ROOT
RUN chsh -s /usr/sbin/nologin root

# CREATE USER
RUN groupadd -r ordix && useradd -m -r -g ordix ordix
RUN echo 'ordix:ordix' | chpasswd
USER ordix 
WORKDIR /home/ordix
ENV HOME /home/ordix

# INSTALL NEOVIM AND TMUX CONFIG
COPY ./.tmux.conf /home/ordix/.tmux.conf
COPY ./nvim /home/ordix/.config/nvim

# MOVE SOURCE CODE IN
COPY ./code /home/ordix/code

# SETUP UP TERMINAL STYLING
ENV TERM xterm-256color
ENV LC_ALL de_DE.utf-8

CMD ["tail", "-f", "/dev/null"]
