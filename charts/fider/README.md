# fider

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.19.1](https://img.shields.io/badge/AppVersion-0.19.1-informational?style=flat-square)

A Helm chart for Fider (non-official)

**Homepage:** <https://getfider.com/>

## Source Code

* <https://github.com/getfider/fider>
* <https://github.com/benjlevesque/helm-charts/tree/main/fider>

## Usage

### tl;dr
```
helm repo add benjlevesque  https://blevesque-helm-charts.s3.fr-par.scw.cloud
helm install fider \
  --set fider.domain=mydomain.org \
  --set fider.noreply=noreply@mydomain.org \
  --set fider.databaseUrl=$(echo -n $DATABASE_URL | base64 -w 0) \
  --set fider.jwtSecret=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$&*' | fold -w 64 | head -n 1 | base64 -w 0) \
  --set fider.smtp.host=smtp.yourdomain.com \
  --set fider.smtp.port=587 \
  benjlevesque/fider
```

### Tutorial
> The following steps use a fake SMTP server and a basic PostgresSQL configuration. This is NOT to be used in production.

- Install [mailhog](https://github.com/mailhog/MailHog) to simulate a SMTP server
```bash
helm repo add codecentric https://codecentric.github.io/helm-charts
helm install mailhog codecentric/mailhog
```

- Install a PostgresSQL instance
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install postgres \
  --set postgresqlPassword=secretpassword,postgresqlDatabase=postgres \
    bitnami/postgresql
```

- Create a `values.test.yaml` file with this content
```
fider:
  domain: "localhost"
  noreply: "noreply@yourdomain.com"
  # postgres://postgres:secretpassword@postgres-postgresql:5432/postgres?sslmode=disable
  databaseUrl: cG9zdGdyZXM6Ly9wb3N0Z3JlczpzZWNyZXRwYXNzd29yZEBwb3N0Z3Jlcy1wb3N0Z3Jlc3FsOjU0MzIvcG9zdGdyZXM/c3NsbW9kZT1kaXNhYmxl
  # abcd
  jwtSecret: YWJjZAo=
  smtp:
    host: mailhog
    port: 1025
```

- Create the fider release
```bash
helm repo add benjlevesque  https://blevesque-helm-charts.s3.fr-par.scw.cloud
helm install fider -f values.test.yaml benjlevesque/fider
```

- open two terminals and run these commands, one in each
```bash
kubectl port-forward svc/mailhog 8025
# in another terminal
kubectl port-forward svc/fider 8000:80
```

- You can now access http://localhost:8000 and play with fider. You will receive emails in Mailhog, at http://localhost:8025

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| extraEnv.LOG_LEVEL | string | `"DEBUG"` |  |
| fider.databaseUrl | string | `""` | The URL to your PostgresSQL instance. Must be either a base64 encoded value or an encrypted sealed secret (required) |
| fider.domain | string | `""` | The domain where your site will be available (required) |
| fider.jwtSecret | string | `""` |  This is a secret value. Use a base64 value, or a Sealed Secret encrypted value |
| fider.noreply | string | `""` | The email address used to send emails (required) |
| fider.smtp.host | string | `""` |  |
| fider.smtp.port | string | `nil` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"getfider/fider"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[{"host":"fider.domain.com","paths":[]}]` |  kubernetes.io/tls-acme: "true" |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  These are secret values. Use base64 values, or Sealed Secret encrypted values extraEnvSecrets:   OAUTH_FACEBOOK_SECRET: |
| resources | object | `{}` |  |
| sealedSecrets | bool | `false` | enables [Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets) for all secret values. Recommended for gitops flows. |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
