***

## Install with helm


# Add the Jetstack Helm repository
```
helm repo add jetstack https://charts.jetstack.io
```

# Update your local Helm chart repository cache

```
helm repo update
```

# Install the cert-manager Helm chart
```
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2 --set installCRDs=true
```

## Setup certificate issuer

[issuer](issuer.yaml)

## Kubectl plugin

```
curl -L -o kubectl-cert-manager.tar.gz https://github.com/jetstack/cert-manager/releases/latest/download/kubectl-cert_manager-linux-amd64.tar.gz

tar xzf kubectl-cert-manager.tar.gz

sudo mv kubectl-cert_manager /usr/local/bin
```


install crds:
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.crds.yaml
```
