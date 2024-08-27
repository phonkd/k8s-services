kubectl create secret generic additional-scrape-configs --from-file=scrapeconfig.yml --dry-run=client -n monitoring -oyaml > additional-scrape-configs.yaml
kubectl apply -f additional-scrape-configs.yaml -n monitoring
