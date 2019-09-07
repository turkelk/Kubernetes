# Installing Helm

What is Helm?

see https://helm.sh

Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

Charts are easy to create, version, share, and publish — so start using Helm and stop the copy-and-paste.

The latest version of Helm is maintained by the CNCF - in collaboration with Microsoft, Google, Bitnami and the Helm contributor community.


1. INSTALLING THE HELM CLIENT 

See https://helm.sh/docs/using_helm/

The Helm client can be installed either from source, or from pre-built binary releases.

From the Binary Releases

Every release of Helm provides binary releases for a variety of OSes. These binary versions can be manually downloaded and installed.

- Download your desired version
See https://github.com/helm/helm/releases

- Unpack it 

```console 
(tar -zxvf helm-v2.14.3-darwin-amd64)
```

- Find the helm binary in the unpacked directory, and move it to its desired destination 
```console 
( mv darwin-amd64/helm /usr/local/bin/helm)
```

2. Init Helm

Run command 

```console 
sh helm-init
```

This command will create service account and cluster role binding for helm tiller for all deployments.