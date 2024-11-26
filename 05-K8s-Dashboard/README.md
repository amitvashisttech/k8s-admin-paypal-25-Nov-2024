
## K8s Dashboard


### Install K8s Dashboard

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
```

### Create a DashBoard Admin Service Account & Grant him ClusterAdminRole

```
kubectl  apply -f dash-admin-sa-and-binding.yaml
```

### Expose the Dashboard Service to NodePort
```
kubectl  get ns
kubectl get svc -n kubernetes-dashboard
kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
kubectl get svc -n kubernetes-dashboard
```

### Now try to open dashbaord url in the browser : https://NodeIP:NodePort

### Genrate Admin Token to Authenticate with K8s Dashboard
```
kubectl -n kubernetes-dashboard create token dashboard-admin
```
