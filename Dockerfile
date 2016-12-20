#
# This docker image is a multi-purpose RHEL 6.8 image design to run most (if not all) the JBoss SET jobs
# on our integration server Thunder: https://thunder.sin2.redhat.com/jenkins/.
#
# Note that to be fully functional, this image needs to be run with the following mounts:
#   /usr/share/javazi-1.8/:/usr/share/javazi-1.8/:ro
#   /opt/:/opt/:ro
#   /home/jboss/.ssh:/home/jboss/.ssh:ro
#   /home/jboss/.gitconfig:/home/jboss/.gitconfig:ro
#   /home/jboss/pull-request-processor/:/home/jboss/pull-request-processor/:ro
#   /home/jboss/.m2:/home/jboss/.m2:rw
#   /home/jboss/jenkins_workspace:/home/jboss/jenkins_workspace:rw

FROM docker.io/fedora
MAINTAINER Romain Pelisse "belaran@redhat.com"

RUN dnf -y install java-1.8.0-openjdk-devel git which wget zip unzip svn tree
RUN dnf -y update

RUN useradd builder
ADD bashrc /home/builder/.bashrc

USER builder
