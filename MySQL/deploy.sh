kubectl create -f namespace.yaml 

kubectl create secret generic mysql-root-pass --from-literal=password=pwd --namespace=db
kubectl create secret generic mysql-user-pass --from-literal=username=tk --from-literal=password=pwd --namespace=db
kubectl create secret generic mysql-db-url --from-literal=database=bex --from-literal=url='Server=mysql;Port=3306;Database=bex;Uid=root;tk=pwd;' --namespace=db
