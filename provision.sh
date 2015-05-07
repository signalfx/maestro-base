#!/bin/bash

# Provisioning script to install utilities needed for SignalFx Docker
# containers: Oracle Java7, wget, git, the Docker client and a few other
# things.

export DEBIAN_FRONTEND=noninteractive

# Disable upstart (some installation steps fail below otherwise and we're not
# going to be using upstart inside containers anyway).
dpkg-divert --local --rename --add /sbin/initctl
rm -f /sbin/initctl
ln -s /bin/true /sbin/initctl

# Install some tools.
apt-get -y install wget git vim unzip lzma pigz

# Install Docker.
wget -q -O - https://get.docker.io/gpg | apt-key add -
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get -y install lxc-docker-1.5.0
apt-get clean

# Oracle Java JDK7u79 (last public release of Java7) must be downloaded and
# installed manually to accept the user agreement.
# See http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html.
