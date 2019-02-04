FROM ubuntu:latest

LABEL maintainer="Jason <lefttjs@gmail.com>"

RUN apt-get update \
    && apt-get install -y \
    wget \
    curl \
    git \ 
    openssh-server \
    automake \
    autoconf \
    libtool \
    gdb \ 
    rsync \
    make \
    cmake \
    build-essential \
    gcc \
    g++ \
    libc++-dev \
    libc++abi-dev \
    python3-pip \
    libssl-dev \
    libffi-dev \
    python3-dev 

#install conan to install some cxx deps
RUN pip3 install conan

# install protobuf
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protobuf-cpp-3.6.1.tar.gz \
    && tar xzvf protobuf-cpp-3.6.1.tar.gz && cd ./protobuf-3.6.1 \
    && ./autogen.sh && ./configure && make && make check && make install && ldconfig 

# enable rsync for clion remote debug
RUN sed -i "s/RSYNC_ENABLE=false/RSYNC_ENABLE=true/g" /etc/default/rsync

# sshd
RUN mkdir /var/run/sshd
# set root passwd to 'passwd'
RUN echo 'root:passwd' | chpasswd 
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/UesPAM yes/UsePAM no/g" /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]