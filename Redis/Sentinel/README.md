see https://github.com/kubernetes/examples/tree/master/staging/storage/redis

# Create a bootstrap master
kubectl create -f redis-master.yaml

# Create a service to track the sentinels
kubectl create -f redis-sentinel-service.yaml

# Create a replication controller for redis servers
kubectl create -f redis-controller.yaml

# Create a replication controller for redis sentinels
kubectl create -f redis-sentinel-controller.yaml

# Scale both replication controllers
kubectl scale rc redis --replicas=3
kubectl scale rc redis-sentinel --replicas=3

# Delete the original master pod
# Note: If you are running all the above commands consecutively including this one in a shell script, it may NOT work out. When you run the above commands, let the pods first come up, especially the redis-master pod. Else, the sentinel pods would never be able to know the master redis server and establish a connection with it.
kubectl delete pods redis-master


### requirepass value on redis.conf should change based on value that mounted from secret to pod on podpreset. I will try
<!-- $password = 'P@ssw0rd@123'   # Command line input
# Update password in config file

sed -i 's/requirepass.*/requirepass $password/' /etc/redis.conf

# Start redis server
redis-server /etc/redis.conf


# Remove password in config file
sed -i 's/requirepass.*/requirepass PASSWORD_REMOVED/' /etc/redis.conf -->