## Incase you are getting the webhook validation error while applying ingress rules like below: 

```
root@master:~/k8s-admin-paypal-25-Nov-2024/07-App-Path-Base-Routing# kubectl apply -f 03-PathBased-Ingress.yaml 
Error from server (InternalError): error when creating "03-PathBased-Ingress.yaml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://ingress-nginx-controller-admission.ingress-nginx.svc:443/networking/v1/ingresses?timeout=10s": context deadline exceeded
root@master:~/k8s-admin-paypal-25-Nov-2024/07-App-Path-Base-Routing#

```


## Then Delete the ValidatingWebhookConfiguration.
```
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
```


## Check the Ingress Rules
```
kubectl get ingress 
kubectl describe ingress 
```


## Now check the Pathbased Routing
```
curl http://34.173.146.121:32441/coffee
curl http://34.173.146.121:32441/tea
```
