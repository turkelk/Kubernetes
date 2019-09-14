# Jaeger
[Jaeger](https://jaeger.readthedocs.io/en/latest/) is a distributed tracing system.

## Installing the Chart using an Existing ElasticSearch Cluster

```console
helm install incubator/jaeger --name jaeger \
 --set provisionDataStore.cassandra=false \
 --set provisionDataStore.elasticsearch=false \
 --set storage.type=elasticsearch \
 --set storage.elasticsearch.scheme=https \ 
 --set storage.elasticsearch.host=elasticsearch-client \
 --set storage.elasticsearch.port=9200 \
```

