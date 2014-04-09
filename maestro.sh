#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Install Maestro for guest utils and extensions.
apt-get -y install git python-setuptools python-pip
pip install docker-py==0.3.1
pip install http://github.com/signalfuse/maestro-ng/archive/maestro-0.1.7.zip

