# Dockerfile for the creation of SignalFuse's base image
#
# This is pretty much just the base Docker image with Java7, Docker (for the
# client) and a few other things installed.

FROM base
MAINTAINER Maxime Petazzoni <max@signalfuse.com>

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install openjdk-7-jdk wget git vim

# Install Docker
RUN sh -c "wget -q -O - https://get.docker.io/gpg | apt-key add -"
RUN sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
RUN apt-get update
RUN apt-get -y install lxc-docker

# Get pipework
RUN mkdir -p /.docker
ADD https://raw.github.com/jpetazzo/pipework/master/pipework /.docker/

CMD ["/bin/bash"]
