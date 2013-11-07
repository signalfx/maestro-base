# Dockerfile for the creation of SignalFuse's base image
#
# This is pretty much just the base Docker image with Java7, Docker (for the
# client) and a few other things installed.

FROM base
MAINTAINER Maxime Petazzoni <max@signalfuse.com>

MKDIR /.docker
ADD provision.sh /.docker/

# Running the provisioning script is disabled until Docker provides a way to do
# privileged image builds automatically (through a RUNP command for example).
#
# RUN /.docker/provision.sh

RUN rm -f /.docker/provision.sh
RUN date > /etc/provisioned_at

CMD ["/bin/bash"]
