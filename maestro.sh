#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Install Maestro for guest utils and extensions.
apt-get -y install python-pip
pip install http://github.com/signalfuse/maestro-ng/archive/maestro-0.1.7.1.zip
