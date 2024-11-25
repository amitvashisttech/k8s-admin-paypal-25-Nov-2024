
Documentation Referred:

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

#### Authenticating with Token:
```sh
kubectl create sa custom-sa
kubectl apply -f pod-0.yaml
kubectl exec -it pod-0 -- bash
```
```sh
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
echo $TOKEN
curl -k -H "Authorization: Bearer $TOKEN" "https://kubernetes/api/v1"
curl -k -H "Authorization: Bearer $TOKEN" "https://kubernetes/api/v1/namespaces"
```

### For our practical, we had added custom-sa as service account

To verify if this approach is working, let's perform some tests.
```sh
kubectl run pod-1 --image=nginx
kubectl exec -it pod-1 -- bash
cd /run
ls
```

### Now Grant Cluster-Admin Role to custom-sa service account 
```
kubectl create clusterrolebinding admin-rolebindngs --clusterrole=cluster-admin --serviceaccount=default:custom-sa
```


```sh
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
echo $TOKEN
curl -k -H "Authorization: Bearer $TOKEN" "https://kubernetes/api/v1"
curl -k -H "Authorization: Bearer $TOKEN" "https://kubernetes/api/v1/namespaces"
```

Note: In case you are getting lookup error then replace kuberntes with service IP : 10.96.0.1 "kubectl  get svc"  


