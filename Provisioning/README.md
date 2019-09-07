# Building a Kubernetes Cluster with Vagrant and Ansible

See https://www.itwonderlab.com/

### Pre requirments to build k8s cluster 

### For Mac

1. Install Vagrant

See https://www.vagrantup.com/downloads.html



2. Install Ansible

  See https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-pip

Ansible can be installed via pip, the Python package manager. If pip isn’t already available on your system of Python, run the following commands to install it:

- Install pip

```console
$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
$ python get-pip.py --user
```

- Then install Ansible

```console
pip install --user ansible
```



3. Provisioning Kubernertes Cluster With Vagrant

In VagrantFile directory run 

```console
vagrant up
```


4. Install kubectl

See https://kubernetes.io/docs/tasks/tools/install-kubectl/

Install kubectl binary with curl on macOS

- Download the latest release:

```console
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
```

- Make the kubectl binary executable.

```console
chmod +x ./kubectl
```

- Move the binary in to your PATH.
```console
sudo mv ./kubectl /usr/local/bin/kubectl
```

- Test to ensure the version you installed is up-to-date:

```console
kubectl version
```
