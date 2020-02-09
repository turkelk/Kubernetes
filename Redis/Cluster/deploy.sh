kubectl create -f namespace.yaml 
# kubectl create secret generic redis-passwd --from-literal=passwd=1234 --namespace=redis
kubectl create configmap redis-config --from-file=launch.sh=launch.sh --namespace=redis
kubectl apply -f service.yaml 
kubectl apply -f statefulset.yaml 