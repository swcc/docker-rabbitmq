#!/bin/sh

# If empty data directory
if [ "$VHOST" ] && [ "$USER" ] && [ "$PASSWORD" ]
then
    # Create postgres data directory
#    mkdir -p /var/lib/postgresql/9.4/main
#    chown -R postgres:postgres /var/lib/postgresql/
#    /sbin/setuser postgres /usr/lib/postgresql/9.4/bin/initdb /var/lib/postgresql/9.4/main/

    # Start rabbitmq
    /usr/bin/service rabbitmq-server start

    # Create users and vhosts here
    # wARNING This way the password is set is not very secure
    # to be reviewed..
    /usr/sbin/rabbitmqctl add_user $USER $PASSWORD
    /usr/sbin/rabbitmqctl add_vhost $VHOST
    /usr/sbin/rabbitmqctl set_permissions -p $VHOST $USER ".*" ".*" ".*"

    # Stop rabbitmq
    /usr/bin/service rabbitmq-server stop
fi

# Launch init process
/sbin/my_init
