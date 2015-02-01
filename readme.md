# Docker RabbitMQ Server

[![Docker Hub](https://img.shields.io/badge/docker-swcc%2Fdocker--rabbitmq-blue.svg?style=flat)](https://registry.hub.docker.com/u/swcc/docker-rabbitmq/)

Then, build the Docker container:

```bash
# cd into the git repository
cd /path/to/repo/docker-rabbitmq
docker build -t rabbitmq .    # Build a Docker image named "rabbitmq" from this location "."
# wait for it to build...

# Run the docker container
docker run -p 5672:5672 -name rabbitmq -d rabbitmq -v /tmp/rabbitmq:/var/lib/rabbitmq/mnesia /sbin/my_init --enable-insecure-key # Give container a name in case it's linked to another app container
```

* `docker run` - starts a new docker container
  * `-p 5672:5672` - Binds the local port 5672 to the container's port 5672, so a local.
  * `-d rabbitmq` - Use the image tagged "rabbitmq"
  * `-v /tmp/rabbitmq:/var/lib/rabbitmq/mnesia` - Use a local directory to persist rabbitmq data
  * `/sbin/my_init` - Run the init scripts used to kick off long-running processes and other bootstrapping, as per [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)
  * `--enable-insecure-key` - Enable a generated SSL key so you can SSH into the container, again as per [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker). Generate your own SSH key for production use.
