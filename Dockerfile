# Dockerfile for the creation of a base image for Maestro-enabled components
#
# This is pretty much just the base Docker image on Ubuntu 15.04 with Oracle
# Java7, Docker (for the client) and a few other things installed. See
# provision.sh for more details of what gets installed and set up.

FROM ubuntu:15.04
MAINTAINER Maxime Petazzoni <max@signalfx.com>

RUN apt-get update && apt-get -y upgrade

RUN mkdir -p /.docker
ADD provision.sh /.docker/
ADD maestro.sh /.docker/

# Running the provisioning script is disabled until Docker provides a way to do
# privileged image builds automatically (through a RUNP command for example).
#
# RUN /.docker/provision.sh
# RUN rm -f /.docker/provision.sh

CMD ["/bin/bash"]
