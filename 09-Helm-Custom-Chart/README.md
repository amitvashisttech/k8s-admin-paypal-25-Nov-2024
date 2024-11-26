```
496  mkdir 09-Helm-Custom-Chart
  497  ls
  498  cd 09-Helm-Custom-Chart/
  499  ls
  500  helm create my-tiny-webapp
  501  ls
  502  apt-get install tree -y 
  503  tree . 
  504  ls
  505  cd my-tiny-webapp/
  506  ls
  507  cat Chart.yaml 
  508  ls
  509  cat values.yaml 
  510  cat templates/service.yaml 
  511  ls
  512  vim values.yaml 
  513  ls
  514  cd ..
  515  ls
  516  helm install my-web my-tiny-webapp --dry-run 
  517  helm install my-web my-tiny-webapp 
  518  helm  list 
  519  kubectl get deploy,pod,svc 
  520  ls
  521  mkdir v1 
  522  ls
  523  mv my-tiny-webapp v1/
  524  ls
  525  cp -rf v1 v2 
  526  ls
  527  cd v2/
  528  ls
  529  cd my-tiny-webapp/
  530  ls
  531  vim Chart.yaml 
  532  vim values.yaml 
  533  ls
  534  cd ..
  535  ls
  536  helm list 
  537  helm upgarde my-web my-tiny-webapp 
  538  helm upgrade my-web my-tiny-webapp 
  539  helm list 
  540  helm history my-web 
  541  kubectl get deploy,pod,svc 
  542  curl http://34.173.146.121:32489
  543  ls
  544  cd ..
  545  ls
  546  cp -rf v2 v3 
  547  ls
  548  cd v3/
  549  ls
  550  vim my-tiny-webapp/Chart.yaml 
  551  vim my-tiny-webapp/values.yaml 
  552  ls
  553  cd ..
  554  ls
  555  cd v3/
  556  helm upgrade my-web my-tiny-webapp 
  557  helm history my-web 
  558  kubectl get deploy,pod,svc 
  559  curl http://34.173.146.121:32489
  560  helm history my-web 
  561  helm rollback my-web 
  562  helm history my-web 
  563  kubectl get deploy,pod,svc 
  564  curl http://34.173.146.121:32489
  565  helm history my-web 
  566  helm rollback my-web 1
  567  helm history my-web 
  568  kubectl get deploy,pod,svc 
```
