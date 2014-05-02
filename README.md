Base Docker image for Maestro-enabled components
================================================

*Note:* you actually cannot run `docker build` with this Dockerfile and
end-up with the fully built image, as some of the software installed
during the provisioning steps required the build to run in privileged
mode, which is not yet supported by Docker. Because of this, running the
provisioning script is disabled in the Dockerfile.

The only way to build this image for now is to build the image once,
then start a privileged container from it and manually execute the
provisioning scripts. Once done, exit the container and commit the
container's state as an image.

The provisioning is split in two scripts so that you can commit an
intermediary layer and more easily change the Maestro version without
rebuilding the full lower layer (which is much bigger) and benefit from
that shared layer.

```
$ docker build -t quay.io/signalfuse/maestro-base:base .
$ docker run -privileged -i -t -privileged quay.io/signalfuse/maestro-base:base bash
root@x:/# .docker/provision.sh
...
root@x:/# exit
$ docker commit <x> quay.io/signalfuse/maestro-base:provision
$ docker insert quay.io/signalfuse/maestro-base:provision ./maestro.sh /.docker/maestro.sh
<y>
$ docker run -i -t <y> bash
root@z:/# .docker/maestro.sh
...
root@z:/# exit
$ docker commit <z> quay.io/signalfuse/maestro-base:<tag>
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
FROM quay.io/signalfuse/maestro-base:0.1.7

# Rest goes here
```

See http://github.com/signalfuse/maestro-ng/README.md for more
information on how to use Maestro and the guest utils (Python-based
helper functions for your container init script).
