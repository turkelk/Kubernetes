# Logging

## Deploy Fluent Bit, Elasticsearch and Kibana

## For Automatic Way

```console
$ sh deploy-logging.sh
```

### For Manuel Way

```console
$ kubectl create namespace logging
```

### Create the Namespace

```console
$ kubectl create namespace logging
```

### Deploy Elasticsearch

Helm installation of Elasticsearch. We will disable persistence for simplicity. Warning this will consume a lot of memory in your cluster.

see https://github.com/helm/charts/tree/master/incubator/elasticsearch

```console
helm install --name elasticsearch stable/elasticsearch \
    --set master.persistence.enabled=false \
    --set data.persistence.enabled=false \
    --namespace logging
```    

### Deploy Kibana

```console
helm install --name kibana stable/kibana \
    --set env.ELASTICSEARCH_URL=http://elasticsearch-client:9200 \
    --namespace logging
```

### Deploy Fluent Bit

```console
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role.yaml
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding.yaml
kubectl apply -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-configmap.yaml
```

### Create the Fluent Bit Config Map


This Config Map will be used as the base configuration of the Fluent Bit container. You will see keywords such as INPUT, OUTPUT, FILTER, and PARSER in this file.

### Deploy the Fluent Bit DaemonSet

Fluent Bit must be deployed as a DaemonSet, so on that way, Kubernetes will ensure that there is at least one FluentBit container running in each Kubernetes node.

You will have to download the YAML file first and modify the FLUENT_ELASTICSEARCH_HOST variable from elasticsearch to elasticsearch-client.

```console
kubectl apply -f fluent-bit/fluent-bit-ds.yaml
```