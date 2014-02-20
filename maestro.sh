#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Install Maestro for guest utils and extensions.
apt-get -y install git python-setuptools python-pip
pip install git+git://github.com/dotcloud/docker-py
pip install http://github.com/signalfuse/maestro-ng/archive/maestro-0.1.6.zip

