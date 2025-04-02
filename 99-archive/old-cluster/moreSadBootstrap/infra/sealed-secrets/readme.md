helm chart installs sealed secret service with name "sealed-secrets`
To make the cli use it do this:
```bash
kubeseal --controller-name sealed-secrets
```
