# create namespace
kubectl create namespace logging

# deploy elasticsearch

helm install --name elasticsearch stable/elasticsearch \
    --set master.persistence.enabled=false \
    --set data.persistence.enabled=false \
    --namespace logging

 # deploy kibana

 helm install --name kibana stable/kibana \
    --set env.ELASTICSEARCH_URL=http://elasticsearch-client:9200 \
    --namespace logging

 # deploy fluent bit      

kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role.yaml
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding.yaml
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-configmap.yaml
kubectl apply -f fb/fluent-bit-ds.yaml