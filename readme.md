# Docker RabbitMQ Server

[![Docker Hub](https://img.shields.io/badge/docker-swcc%2Fdocker--rabbitmq-blue.svg?style=flat)](https://registry.hub.docker.com/u/swcc/docker-rabbitmq/)

Then, build the Docker container:

```bash
# cd into the git repository
cd /path/to/repo/docker-rabbitmq
docker build -t rabbitmq .    # Build a Docker image named "rabbitmq" from this location "."
# wait for it to build...

# Run the docker container
docker run -p 5672:5672 -name rabbitmq -d rabbitmq -v /tmp/rabbitmq:/var/lib/rabbitmq/mnesia /sbin/my_init 
```
_[] options means they are optional_

* `docker run` - starts a new docker container
  * `-p 5672:5672` - Binds the local port 5672 to the container's port 5672, so a local.
  * `-d rabbitmq` - Use the image tagged "rabbitmq"
  * [] `-v /tmp/rabbitmq:/var/lib/rabbitmq/mnesia` - Use a local directory to persist rabbitmq data
  * [] `-e USER=myuser -e PASSWORD=mypwd -e VHOST=myvhost` - Creates a user and an associated vhost on startup
  * `/sbin/my_init` - Run the init scripts used to kick off long-running processes and other bootstrapping, as per [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)

