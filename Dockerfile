FROM fedora

RUN dnf -y install java-1.8.0-openjdk-devel git which wget zip unzip svn tree iputils iproute net-tools maven vim-enhanced
RUN dnf -y update

RUN useradd -m builder #add user with home directory
ADD bashrc /home/builder/.bashrc
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN echo "root:docker" | chpasswd
USER builder
