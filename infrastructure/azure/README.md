# Azure Kubernetes Services

### Build cluster
- Given terraform script will setup a standard Azure Kubernetes Service cluster on your Azure portal
- You will need to have your azure user credentials handy before running the terraform commands
- Initialize tf
```
terraform init
```
- Plan your deploy (optional but recommended)
```
terraform plan
```
- Deploy your cluster
```
terraform apply
```

### Post cluster build steps
- Terraform output will generate the kubeconfig file
- Save this output to a file and add it to your `KUBECONFIG` path
```
terraform output kube_config > $HOME/.kube/azure
```
- Check the cluster nodes
```
kubectl get nodes --kubeconfig=$HOME/.kube/azure
```
***Setting the `--kubeconfig` flag gives us control over which cluster we want to run our commands***
### Teardown cluster
```
terraform destroy
```