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
apt-get -y dist-upgrade

# Install Java, Python and some tools.
apt-get -y install openjdk-7-jdk wget git vim golang-go

# Install Docker.
wget -q -O - https://get.docker.io/gpg | apt-key add -
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get -y install lxc-docker

# Get pipework.
wget -O /.docker/pipework https://raw.github.com/jpetazzo/pipework/master/pipework

# Install Maestro for guest utils.
apt-get -y install python-setuptools
easy_install http://github.com/signalfuse/maestro-ng/archive/maestro-0.1.5.zip

# Install pipestash (logstash forwarder).
apt-get -y install python-redis
git clone https://github.com/1stone/pipestash.git /.docker/pipestash
cd /.docker/pipestash
python setup.py install

# Clean up.
cd /
rm -rf /.docker/pipestash /.bash_history
apt-get clean
