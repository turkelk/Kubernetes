#!/bin/bash
# PASSWORD=$( cat /etc/redis-passwd/passwd )
if [[ "${HOSTNAME}" != "redis-0" ]] ; then 
    # redis-server --requirepass ${PASSWORD}
    echo "ok"
else 
    redis-server --slaveof redis-0.redis 6379 
fi
