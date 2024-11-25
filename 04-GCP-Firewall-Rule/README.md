# Create a GCP Firewall Rule to enable K8s Service NodePort Access from Internet.



### Search "Firewall Rule -> VPC" 

### Name : k8s-svc 
### Tag  : k8s-svc 
### Source : 0.0.0.0/0
### Protocol: TCP
### Port Range: 30000-32767


## Now Edit the nodes & add the "k8s-svc" tag in firewall section 



## Test the connection: 
```
root@master:~/k8s-admin-paypal-05-Nov-2024# kubectl run hello-k8s-4 --image=nginx --port=80 
pod/hello-k8s-4 created
```

```
root@master:~/k8s-admin-paypal-05-Nov-2024# kubectl get pods 
NAME          READY   STATUS    RESTARTS   AGE
hello-k8s-4   1/1     Running   0          6s
```

```
root@master:~/k8s-admin-paypal-05-Nov-2024# kubectl expose pod hello-k8s-4 --type=NodePort 
service/hello-k8s-4 exposed
```
```
root@master:~/k8s-admin-paypal-05-Nov-2024# kubectl get pods -o wide 
NAME          READY   STATUS    RESTARTS   AGE   IP                NODE       NOMINATED NODE   READINESS GATES
hello-k8s-4   1/1     Running   0          34s   192.168.133.201   worker-2   <none>           <none>
```
```
root@master:~/k8s-admin-paypal-05-Nov-2024# kubectl get svc 
NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
hello-k8s-4   NodePort    10.107.153.241   <none>        80:31956/TCP   18s
kubernetes    ClusterIP   10.96.0.1        <none>        443/TCP        23h
root@master:~/k8s-admin-paypal-05-Nov-2024# 
```
```
curl http://PublicIPofRespectiveWorkerNode:NodePort/
```
