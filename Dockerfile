#
# This docker image is a multi-purpose RHEL 6.8 image design to run Java builds
#

FROM docker.io/fedora
MAINTAINER Romain Pelisse "belaran@redhat.com"

RUN dnf -y install java-1.8.0-openjdk-devel git which wget zip unzip svn tree
RUN dnf -y update

RUN useradd builder
ADD bashrc /home/builder/.bashrc

USER builder
