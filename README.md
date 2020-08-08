# Helm Charts

This repository contains helm charts for all CloudHut products. As of now there's only the Kowl helm chart which is documented below.

## Installing the helm chart

```
helm repo add cloudhut https://raw.githubusercontent.com/cloudhut/charts/master/archives
helm repo update
helm install -f values.yaml --name=kowl cloudhut/kowl
```

## Chart configuration

| Parameter | Description | Default |
| --- | --- | --- |
| `replicaCount` | Number of Kowl replicas | `1` |
| `image.repository` | Docker image repo | `quay.io/cloudhut/kowl` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.tag` | Image tag | `v1.0.0` (inherited) |
| `imagePullSecrets` | Reference to one or more secrets to be used when pulling images | `s` |
| `nameOverride` | Expand the name of the chart | (none) |
| `fullnameOverride` | Create a default fully qualified app name | (none) |
| `serviceAccount.create` | Create a new service account | `true` |
| `serviceAccount.annotations` | Annotations for new service account | `{}` |
| `serviceAccount.name` | Service Account Name | (none / generated if create is true) |
| `podAnnotations` | Annotations to attach on Kowl pod | `{}` |
| `podSecurityContext` | Pod Security Context | `{runAsUser: 99, fsGroup: 99}` |
| `securityContext` | Container Security Context | `{runAsNonRoot: true}` |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `80` |
| `service.type` | Annotations to attach to service | `{}` |
| `ingress.enabled` | Whether or not to deploy an ingress | `false` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts[0].host` | Ingress hostname | `chart-example.local` |
| `ingress.hosts[0].patghs` | Path within the url structure | `[]` |
| `ingress.tls` | TLS configuration for the ingress | `[]` |
| `resources` | Resource configuration for deployment | `{}` |
| `autoscaling.enabled` | Whether or not to deploy a horizontal pod autoscaler | `false` |
| `autoscaling.minReplicas` | Minimum number of replicas | `1` |
| `autoscaling.maxReplicas` | Maximum number of replicas | `100` |
| `autoscaling.targetCPUUtilizationPercentage` | Target average utilization for CPU in % | `80` |
| `autoscaling.targetMemoryUtilizationPercentage` | Target average utilization for RAM in % | (none) |
| `nodeSelector` | Node selector used in deployment | `{}` |
| `tolerations` | Tolerations for tainted nodes | `[]` |
| `affinity` | Pod (anti)affinities | `{}` |
| `kowl.config` | Kowl config content | `{}` |
| `kowl.roles` | Kowl roles config content (business) | (none) |
| `kowl.roleBindings` | Kowl rolebindings config content (business) | (none) |
| `secret.existingSecret` | Secret name of an existing secret (see notes below) | (none) |
| `secret.kafka.saslPassword` | Kafka sasl password value | (none) |
| `secret.kafka.tlsCa` | Kafka TLS ca file | (none) |
| `secret.kafka.tlsCert` | Kafka TLS cert file | (none) |
| `secret.kafka.tlsKey` | Kafka TLS key | (none) |
| `secret.kafka.tlsPassphrase` | Kafka TLS passphrase | (none) |
| `secret.cloudhut.licenseToken` | License token for Kowl business (business) | (none) |
| `login.google.clientSecret` | Google OAuth client secret (business) | (none) |
| `login.github.clientSecret` | GitHub OAuth client secret (business) | (none) |
| `login.github.personalAccessToken` | GitHub personal access token (business) | (none) |

Further documentation can be found in the [examples](./examples).

### Kowl Config / Mounted secrets

With this chart you can specify the whole YAML config for Kowl (Business). This includes path to files which may be mounted by this chart. This is the list of static paths which you may need to specify in the config in case you use them:

| Type | Path |
| --- | --- |
| Config | `/etc/kowl/configs/config.yaml` |
| Roles | `/etc/kowl/configs/roles.yaml` |
| Role Bindings | `/etc/kowl/configs/role-bindings.yaml` |
| Kafka TLS CA | `/etc/kowl/secrets/kafka-tls-ca` |
| Kafka TLS Cert | `/etc/kowl/secrets/kafka-tls-cert` |
| Kafka TLS Key | `/etc/kowl/secrets/kafka-tls-key` |
| Google Groups Service Account | `/etc/kowl/secrets/login-google-groups-service-account.json` |

### Using an existing secret

If you prefer to use an existing secret rather than creating a new one with this chart you **must** specify all keys. Please take a look at the [sample manifest](./examples/secret.yaml).
