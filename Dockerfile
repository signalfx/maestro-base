# Dockerfile for the creation of a base image for Maestro-enabled components
#
# Copyright (C) 2013-2014 SignalFuse, Inc. All rights reserved.
# Copyright (C) 2015-2017 SignalFx, Inc. All rights reserved.

FROM alpine:3.7
MAINTAINER Maxime Petazzoni <max@signalfx.com>

ADD ./rootfs /
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk --update add \
      bash \
      ca-certificates \
      curl \
      gcc \
      git \
      libc-dev \
      python-dev \
      py-pip \
      linux-headers \
      vim \
    && pip install --upgrade pip maestro-ng \
    && apk del gcc \
    && rm -rf /var/cache/apk/* \
    && addgroup -g 9739 -S maestro \
    && adduser -u 9739 -g 9739 -S -G maestro maestro \
    && echo "base built $(date)" >> /root/.built


CMD ["/bin/bash"]
