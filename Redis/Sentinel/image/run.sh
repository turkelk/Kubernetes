#!/bin/bash
# https://redis.io/topics/sentinel
# Fundamental things to know about Sentinel before deploying
# You need at least three Sentinel instances for a robust deployment.
# The three Sentinel instances should be placed into computers or virtual machines that are believed to fail in an independent way. So for example different physical servers or Virtual Machines executed on different availability zones.
# Sentinel + Redis distributed system does not guarantee that acknowledged writes are retained during failures, since Redis uses asynchronous replication. However there are ways to deploy Sentinel that make the window to lose writes limited to certain moments, while there are other less secure ways to deploy it.
# You need Sentinel support in your clients. Popular client libraries have Sentinel support, but not all.
# There is no HA setup which is safe if you don't test from time to time in development environments, or even better if you can, in production environments, if they work. You may have a misconfiguration that will become apparent only when it's too late (at 3am when your master stops working).
# Sentinel, Docker, or other forms of Network Address Translation or Port Mapping should be mixed with care: Docker performs port remapping, breaking Sentinel auto discovery of other Sentinel processes and the list of replicas for a master. Check the section about Sentinel and Docker later in this document for more information.

# PASSWORD=$( cat /etc/redis-passwd/passwd )
function launchmaster() {
  if [[ ! -e /redis-master-data ]]; then
    echo "Redis master data doesn't exist, data won't be persistent!"
    mkdir /redis-master-data
  fi
  # sed -i "s/requirepass.*/requirepass ${PASSWORD}/" /redis-master/redis.conf
  redis-server /redis-master/redis.conf --protected-mode no
}

function launchsentinel() {
  while true; do
    master=$(redis-cli -h ${REDIS_SENTINEL_SERVICE_HOST} -p ${REDIS_SENTINEL_SERVICE_PORT} --csv SENTINEL get-master-addr-by-name mymaster | tr ',' ' ' | cut -d' ' -f1)
    if [[ -n ${master} ]]; then
      master="${master//\"}"
    else
      master=$(hostname -i)
    fi

    redis-cli -h ${master} INFO
    if [[ "$?" == "0" ]]; then
      break
    fi
    echo "Connecting to master failed.  Waiting..."
    sleep 10
  done

  sentinel_conf=sentinel.conf
  
  # https://redis.io/topics/sentinel

  echo "sentinel monitor mymaster ${master} 6379 2" > ${sentinel_conf}
  echo "sentinel down-after-milliseconds mymaster 60000" >> ${sentinel_conf}
  echo "sentinel failover-timeout mymaster 180000" >> ${sentinel_conf}
  echo "sentinel parallel-syncs mymaster 1" >> ${sentinel_conf}
  echo "bind 0.0.0.0" >> ${sentinel_conf}

  redis-sentinel ${sentinel_conf} --protected-mode no
}

function launchslave() {
  while true; do
    master=$(redis-cli -h ${REDIS_SENTINEL_SERVICE_HOST} -p ${REDIS_SENTINEL_SERVICE_PORT} --csv SENTINEL get-master-addr-by-name mymaster | tr ',' ' ' | cut -d' ' -f1)
    if [[ -n ${master} ]]; then
      master="${master//\"}"
    else
      echo "Failed to find master."
      sleep 60
      exit 1
    fi
    redis-cli -h ${master} INFO
    if [[ "$?" == "0" ]]; then
      break
    fi
    echo "Connecting to master failed.  Waiting..."
    sleep 10
  done
  sed -i "s/%master-ip%/${master}/" /redis-slave/redis.conf
  sed -i "s/%master-port%/6379/" /redis-slave/redis.conf
  redis-server /redis-slave/redis.conf --protected-mode no
}

if [[ "${MASTER}" == "true" ]]; then
  launchmaster
  exit 0
fi

if [[ "${SENTINEL}" == "true" ]]; then
  launchsentinel
  exit 0
fi

launchslave
