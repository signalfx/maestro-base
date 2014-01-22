Base Docker image for Maestro-enabled components
================================================

*Note:* you actually cannot run `docker build` with this Dockerfile as
some of the software installed during the provisioning steps required
the build to run in privileged mode, which is not yet supported by
Docker.

The only way to build this image for now is to build the image once,
then start a container from it and manually execute the provisioning
script. Once done, exit the container and commit the container's state
as an image.

```
$ docker build -t quay.io/signalfuse/maestro-base:<tag> .
$ docker run -privileged -i -t -privileged quay.io/signalfuse/maestro-base
root@x:/# .docker/provision.sh
...
root@x:/# exit
$ docker commit <x> quay.io/signalfuse/maestro-base:<tag>
```

What's inside?
--------------

This base image provides a sane foundation for the Docker images of
components orchestrated by
[Maestro](https://github.com/signalfuse/maestro-ng). It provides:

- Java 7, via `openjdk-7-jdk`;
- Docker, to have the client available to talk to Docker daemons from
  within a container;
- Pipework, for advanced container networking (if needed);
- Git and Wget, to download packages or repositories during provisioning
  of sub-images;
- Vim, for sane editing when one needs to drop into a shell inside the
  container;
- Maestro guest utils functions;
- Pipestash, for log forwarding to Logstash.

Usage
-----

Simply start your `Dockerfile` with the following FROM line to get
started:

```
FROM quay.io/signalfuse/maestro-base:0.1.5

# Rest goes here
```

See http://github.com/signalfuse/maestro-ng/README.md for more
information on how to use Maestro and the guest utils (Python-based
helper functions for your container init script).
