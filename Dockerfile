FROM fedora

RUN dnf -y install java-1.8.0-openjdk-devel git which wget zip unzip svn tree iputils iproute net-tools maven
RUN dnf -y update

RUN useradd builder
ADD bashrc /home/builder/.bashrc

RUN echo "root:docker" | chpasswd
USER builder
