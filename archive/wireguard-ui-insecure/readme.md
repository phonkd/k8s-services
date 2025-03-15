k create secret generic wg-creds --from-literal=PASSWORD_HASH='pw_hash generated with docker run command from wg manual' --from-literal=WG_HOST='wghosttt' --dry-run=client -o yaml > secretnew.yml

kubeseal --controller-name sealed-secrets -f secretnew.yml -w secret.yaml
