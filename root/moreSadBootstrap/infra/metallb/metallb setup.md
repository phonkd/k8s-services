***

```
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb --namespace metallb-system --create-namespace
```

>[!output]
>Now you can configure it via its CRs. Please refer to the metallb official docs on how to use the CRs.

## Configure ipadresspool and l2advertisement (?)

[metallb-ip-pool](metallb-ip-pool.yaml)

>[!warning] Adjust the addresses in the `metallb-ip-pool` file.

## Check if the loadbalancer got an ip adress in the lan:

```bash
kubectl get pods,services --all-namespaces
```