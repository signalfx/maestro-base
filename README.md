# Base Docker image for Maestro-enabled components

![SignalFx](https://raw.githubusercontent.com/signalfx/maestro-base/latest/logo/sfx.png) ![Alpine](https://raw.githubusercontent.com/signalfx/maestro-base/latest/logo/alpine.png)

This base image provides a sane foundation for the Docker images of
components orchestrated by
[MaestroNG](https://github.com/signalfuse/maestro-ng). It's based on
[Alpine Linux](http://alpinelinux.org/) and provides a lightweight base
to build applications upon. It contains:

- `git`, `wget`, `tar` to download packages or repositories during
  provisioning of sub-images;
- `bash` and `vim`, for a sane troubleshooting environment inside the
  container;
- Python with `pip`;
- MaestroNG, for its guest utils functions.

See http://maestro-ng.readthedocs.org/en/latest/guest-functions/ for
more information on how to use Maestro and the guest utils (Python-based
helper functions for your container init script).

# Choosing a Java runtime

![Java](https://raw.githubusercontent.com/signalfx/maestro-base/latest/logo/java.png)

The `:alp-3.2` base image does not include a Java runtime. For this, two
additional images are available: `:alp-3.2-jdk7` and `:alp-3.2-jdk8`
that offer Java 7 and Java 8, respectively.

To use, setup your `Dockerfile` like so:

```Dockerfile
FROM quay.io/signalfuse/maestro-base:alp-3.2-jdk8
...
```

# Building

## Building the base image

```
$ docker build -t quay.io/signalfuse/maestro-base:alp-3.2 .
```

## Building a Java base image

```
$ JAVA_VERSION=8 docker build \
  -f java/Dockerfile.${JAVA_VERSION} \
  -t quay.io/signalfuse/maestro-base:alp-3.2-jdk${JAVA_VERSION} \
  java/
```
