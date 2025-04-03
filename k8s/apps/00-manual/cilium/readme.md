```
helm repo add cilium https://helm.cilium.io/
```

```
helm install cilium cilium/cilium --version 1.17.2 \
  --namespace kube-system --values ciliumvalues.yaml
```
