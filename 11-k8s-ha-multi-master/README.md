# Set up a Highly Available Kubernetes Cluster using kubeadm
Follow this documentation to set up a highly available Kubernetes cluster using __Ubuntu 20.04 LTS__.

This documentation guides you in setting up a cluster with two master nodes, one worker node and a load balancer node using HAProxy.

## Vagrant Environment
|Role|FQDN|IP|OS|RAM|CPU|
|----|----|----|----|----|----|
|Load Balancer|loadbalancer.example.com|172.16.16.100|Ubuntu 20.04|1G|1|
|Master|kmaster1.example.com|172.16.16.101|Ubuntu 20.04|2G|2|
|Master|kmaster2.example.com|172.16.16.102|Ubuntu 20.04|2G|2|
|Master|kmaster3.example.com|172.16.16.103|Ubuntu 20.04|2G|2|
|Worker|kworker1.example.com|172.16.16.201|Ubuntu 20.04|1G|1|
|Worker|kworker2.example.com|172.16.16.202|Ubuntu 20.04|1G|1|

> * Password for the **root** account on all these virtual machines is **kubeadmin**
> * Perform all the commands as root user unless otherwise specified

## Pre-requisites
If you want to try this in a virtualized environment on your workstation
* Virtualbox installed
* Vagrant installed
* Host machine has atleast 8 cores
* Host machine has atleast 8G memory

## Bring up all the virtual machines
```
vagrant up
```

## Set up load balancer node
##### Install Haproxy
```
apt update && apt install -y haproxy
```
##### Configure haproxy
Append the below lines to **/etc/haproxy/haproxy.cfg**
```
frontend kubernetes-frontend
    bind 172.16.16.100:6443
    mode tcp
    option tcplog
    default_backend kubernetes-backend

backend kubernetes-backend
    mode tcp
    option tcp-check
    balance roundrobin
    server kmaster1 172.16.16.101:6443 check fall 3 rise 2
    server kmaster2 172.16.16.102:6443 check fall 3 rise 2
```
##### Restart haproxy service
```
systemctl restart haproxy
```

## On all kubernetes nodes (kmaster1, kmaster2, kmaster3, kworker1 &  kworker2)
```
vagrant ssh <nodename>
sudo -i 
git clone https://github.com/amitvashisttech/cka-ericsson-02-Sept-2024.git ; cd cka-ericsson-02-Sept-2024/00-Setup ; sh install-k8s-worker-node.sh
```


## On any one of the Kubernetes master node (Eg: kmaster1)
##### Initialize Kubernetes Cluster
```
kubeadm init --control-plane-endpoint="172.16.16.100:6443" --upload-certs --apiserver-advertise-address=172.16.16.101 --pod-network-cidr=192.168.0.0/16 --cri-socket unix://var/run/crio/crio.sock
```
Copy the commands to join other master nodes and worker nodes.

##### Sample Init MSG
```
---
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join 172.16.16.100:6443 --token t0x54z.wwds5sylsmiq3u6o \
        --discovery-token-ca-cert-hash sha256:d93280dbfe16b137f2ecec30b194cb73469d88ba285b9b79d94eb3a354006ea4 \
        --control-plane --certificate-key e8ae2e8a739802e528e42dfa92fece207b330a622c1091749a51c6481c254f48

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.16.16.100:6443 --token t0x54z.wwds5sylsmiq3u6o \
        --discovery-token-ca-cert-hash sha256:d93280dbfe16b137f2ecec30b194cb73469d88ba285b9b79d94eb3a354006ea4
```        

#####  To start using your cluster, you need to run the following:
```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
#####  Check node Status 
```
root@kmaster1:# kubectl  get nodes
NAME       STATUS   ROLES           AGE   VERSION
kmaster1   Ready    control-plane   36m   v1.29.9
```
##### Deploy Calico network
```
kubectl apply -f calico.yaml
```

## Join other nodes to the cluster (kmaster2, kmaster3 & kworker1)
-  Use the respective kubeadm join commands you copied from the output of kubeadm init command on the first master.

- IMPORTANT: You also need to apend your token with --apiserver-advertise-address to the join cluster as another master node.

## Downloading kube config to your local machine
On your host machine
```
mkdir ~/.kube
scp root@172.16.16.101:/etc/kubernetes/admin.conf ~/.kube/config
```
Password for root account is kubeadmin (if you used my Vagrant setup)

## Verifying the cluster
```
kubectl cluster-info
kubectl get nodes
kubectl get cs
```

Have Fun!!
