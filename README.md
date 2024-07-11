# KubeSecretSync

KubeSecretSync or **KSS** is a simple and efficient tool for synchronizing secrets from Vault and other secret managers into Kubernetes secrets. Unlike more complex solutions, KubeSecretSync offers an easy-to-use interface and straightforward configuration, making it ideal for lightweight and secure secret management in Kubernetes environments.

## Getting Started

KubeSecretSync integrates with your Kubernetes deployments using annotations. Follow the steps below to set up KubeSecretSync in your cluster:

## Installation

1. Deploy KubeSecretSync.

    Apply the KubeSecretSync deployment manifest to your Kubernetes cluster:

```
kubectl apply -f https://path/to/kubesecretsync/deployment.yaml
```

## Usage

2. Annotate Your Deployment

    Add the following annotations to your Kubernetes deployment to specify which secrets to synchronize:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-app
  annotations:
    kss.provider.vault/path: "secret/data/example-app"
    kss.provider.vault/keys: "db-username,db-password"
    kss.provider.config/config-secret: "vault-kss-secret"
    kss.provider.config/config-secret-namespace: "kss-ns"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: example-app
  template:
    metadata:
      labels:
        app: example-app
    spec:
      containers:
      - name: app
        image: example/app:latest
        env:
        - name: DB_USERNAME
          valueFrom:
            secretKeyRef:
              name: example-app-secrets
              key: db-username
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: example-app-secrets
              key: db-password
```

