FROM ubuntu:latest

LABEL maintainer="Jason <lefttjs@gmail.com>"


RUN apt-get update && apt-get install -y \
    openssh-server \
    rsync \
    wget \
    curl \
    git \
    cmake \ 
    make 

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