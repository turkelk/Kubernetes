# Monitoring
### prometheus-operator

Installs [prometheus-operator](https://github.com/coreos/prometheus-operator) to create/configure/manage Prometheus clusters atop Kubernetes. This chart includes multiple components and is suitable for a variety of use-cases.


## Introduction

This chart bootstraps a [prometheus-operator](https://github.com/coreos/prometheus-operator) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.  The chart can be installed multiple times to create separate Prometheus instances managed by Prometheus Operator.

## Prerequisites
  - Kubernetes 1.10+ with Beta APIs
  - Helm 2.10+ (For a workaround using an earlier version see [below](#helm-210-workaround))

## Installing the Chart

To install the chart with the release name `prometheus-operator`:

```console
$ helm install stable/prometheus-operator \
    --namespace monitoring \
    --name prometheus-operator \
    --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false
```

The command deploys prometheus-operator on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

The default installation includes Prometheus Operator, Alertmanager, Grafana, and configuration for scraping Kubernetes infrastructure.

### Purpose of prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false 
 Command will cause empty serviceMonitorSelector, so Prometheus will select all serviceMonitor running anywhere in the cluster. So there is no need for release or label selector.

## Accessing the interfaces of the Prometheus Operator

To quickly get a glimpse of the interfaces that you just deployed, you can use the port-forward capabilities of kubectl.

```console
kubectl port-forward grafana-5568b65944-nwbct -n monitoring 3000:3000
```

Now point your web browser to seee http://localhost:3000 , you will access the Grafana interface, which is already populated with some useful dashboards!

## Uninstalling the Chart

To uninstall/delete the `prometheus-operator` deployment:

```console
$ helm delete prometheus-operator
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

CRDs created by this chart are not removed by default and should be manually cleaned up:

```console
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
```