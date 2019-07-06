### Instructions to deploy web app backend

- Run `kubectl apply -f mysql_app.yml` to deploy the mysql pod and service
- Run `kubectl apply -f mysql_pv.yml` to deploy the PVC
- Run the mysql pod to create a new database. Run the following command to do this
```
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -ppassword
```
- Once you run this, create a new database using the `CREATE DATABASE *databasename*` command
- Run `kubectl apply -f spring_webapp.yml` to deploy the backend application pod and service
- Wait for the loadbalancer service to come up and provide a DNS

***Your REST Api is now ready to accept requests at various endpoints***
