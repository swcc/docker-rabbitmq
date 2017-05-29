FROM phusion/baseimage:latest
MAINTAINER paul+swcc@bonaud.fr

# Set correct environment variables
ENV HOME /root

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# ################
# Install RabbitMQ
RUN echo "deb https://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list.d/rabbitmq.list
RUN curl http://www.rabbitmq.com/rabbitmq-release-signing-key.asc >> rabbitmq-signing-key-public.asc
RUN sudo apt-key add rabbitmq-signing-key-public.asc
RUN apt-get update && apt-get install -y rabbitmq-server
# ################

# Create a runit entry for your app
RUN mkdir -p /etc/service/rabbitmq
ADD run.sh /etc/service/rabbitmq/run
RUN chown root /etc/service/rabbitmq/run
RUN chmod +x /etc/service/rabbitmq/run

# And a setup script
ADD build/setup.sh /etc/rabbitmq/setup.sh
RUN chmod +x /etc/rabbitmq/setup.sh

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose application port (RabbitMQ runs on 5672)
EXPOSE 5672

# Use baseimage-docker's init system
CMD ["/etc/rabbitmq/setup.sh"]
