***

```
helm install -f values.yaml gitea gitea-charts/gitea --namespace gitea
```


## Foreword

Getting ssh to work is tricky and does not work with the solution from gitea for me.
My solution works by:
- Creating a separate load balancer pointing to the `svc/gitea-ssh`
- Assigning this loadbalancer another ip
- Setting the `SSH_DOMAIN` to a dns record pointing to `loadbalancer ip`

## Requirements

- [metallb](metallb%20setup.md) setup
- [metallb-ip-pool](metallb-ip-pool.yaml) created
- [ingress-nginx](ingress-nginx.md) installed and configured

## Setup

([values](svcs/k8s/gitea/values.yaml))
1. Download gitea values.yaml
2. Adjust according to need (I disabled High availability because of 8 volumes a 8gi being created) ![](Pasted%20image%2020231129192056.png)
3. Change `gitea.config.server.SSH_DOMAIN` to your desired domain ![](Pasted%20image%2020231129192212.png)
4. (optional) enable internal ingress (**note that `host` must differ from the `SSH_DOMAIN`**)![](Pasted%20image%2020231129192302.png)
5. Configure the ssh service ![](Pasted%20image%2020231129192434.png)
	1. `type: LoadBalancer`
	2. `loadBalancerIP:` `free ip in metallb ippool`
	3. `port`: `22`
6. create user `gitea admin user create --email ig@du.ch --username kekl --password sml12345`


## Using a different Port for ssh

see [[svcs/k8s/gitea/values.yaml]] 
- `service.ssh.port` 
- `gitea.config.server.SSH_DOMAIN`
- `USE_COMPAT_SSH_URI` (this changes the url to add a prefix (`ssh://`) which is needed for using non standart ssh port)