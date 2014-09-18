FROM phusion/baseimage:latest
MAINTAINER paul+swcc@bonaud.fr

# Set correct environment variables
ENV HOME /root

# ################
# Install RabbitMQ
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list.d/rabbitmq.list
RUN curl http://www.rabbitmq.com/rabbitmq-signing-key-public.asc >> rabbitmq-signing-key-public.asc
RUN sudo apt-key add rabbitmq-signing-key-public.asc
RUN apt-get update && apt-get install -y rabbitmq-server


# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Spin-docker currently supports exposing port 22 for SSH and
# one additional application port (RabbitMQ runs on 5672)
EXPOSE 5672

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
