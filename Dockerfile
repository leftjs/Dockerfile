FROM ubuntu:16.04

LABEL maintainer="Jason <lefttjs@gmail.com>"

RUN apt-get update \
    && apt-get install -y \
    zsh \
    build-essential \ 
    unzip \
    vim \
    curl \
    git \
    make \
    g++ \
    clang-3.9 \
    llvm \
    wget \
    pkg-config \
    openssh-server \
    # libgtest-dev \
    # libboost-all-dev \
    automake \
    autoconf \
    libtool \
    gdb \ 
    rsync 

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.9 1
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.9 1
RUN apt-get install -y libc++-dev libc++abi-dev libtbb-dev

WORKDIR /opt/cxx

# fix '__cxxabi_config.h' file not found //// refer to https://github.com/ucbrise/anna/issues/1#issuecomment-380605899
RUN ln -s /usr/include/libcxxabi/__cxxabi_config.h /usr/include/c++/v1/__cxxabi_config.h

# install cmake
RUN wget https://cmake.org/files/v3.9/cmake-3.9.4-Linux-x86_64.tar.gz && tar xvzf cmake-3.9.4-Linux-x86_64.tar.gz && mv cmake-3.9.4-Linux-x86_64 /usr/bin/cmake
ENV PATH=$PATH:/usr/bin/cmake/bin
RUN rm -rf cmake-3.9.4-Linux-x86_64.tar.gz

# install protobuf
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v2.6.0/protobuf-2.6.0.tar.gz \
    && tar xzvf protobuf-2.6.0.tar.gz && cd protobuf-2.6.0 \
    && ./autogen.sh && ./configure \
    && make && make check && make install && ldconfig && cd .. && rm -rf protobuf*


# c/cxx env
# ENV LD_LIBRARY_PATH=/libs
# ENV CPLUS_INCLUDE_PATH=/libs/include

# enable rsync for clion remote debug
RUN sed -i "s/RSYNC_ENABLE=false/RSYNC_ENABLE=true/g" /etc/default/rsync

# # zsh 
# RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# RUN chsh -s /usr/bin/zsh

# sshd
RUN mkdir /var/run/sshd
# set root passwd to 'passwd'
RUN echo 'root:passwd' | chpasswd 
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/UesPAM yes/UsePAM no/g" /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]



