FROM ubuntu:latest

LABEL maintainer="Jason <lefttjs@gmail.com>"

RUN apt-get update \
    && apt-get install -y \
    zsh \
    vim \
    curl \
    git \
    make \
    cmake \
    gcc \
    wget \
    openssh-server \
    build-essential \ 
    # libgtest-dev \
    # libboost-all-dev \
    automake \
    autoconf \
    gdb

# c/cxx env
# ENV LD_LIBRARY_PATH=/libs
# ENV CPLUS_INCLUDE_PATH=/libs/include

# zsh 
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s /usr/bin/zsh

# sshd
RUN mkdir /var/run/sshd
# set root passwd to 'passwd'
RUN echo 'root:passwd' | chpasswd 
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/UesPAM yes/UsePAM no/g" /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]



