#!/bin/bash

# Provisioning script to install utilities needed for SignalFuse Docker
# containers: Java7, wget, git, the Docker client and a few other things.

export DEBIAN_FRONTEND=noninteractive

# Disable upstart (some installation steps fail below otherwise and we're not
# going to be using upstart inside containers anyway).
dpkg-divert --local --rename --add /sbin/initctl
rm -f /sbin/initctl
ln -s /bin/true /sbin/initctl

apt-get update

# Install Java, Python and some tools.
apt-get -y install openjdk-7-jdk wget git vim

# Install Docker.
wget -q -O - https://get.docker.io/gpg | apt-key add -
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get -y install lxc-docker-0.8.0
apt-get clean
