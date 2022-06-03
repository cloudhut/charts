# Helm Charts

This repository contains helm charts for all CloudHut products. As of now there's only the Kowl helm chart which is documented below.

## Installing the helm chart

```
helm repo add cloudhut https://raw.githubusercontent.com/cloudhut/charts/master/archives
helm repo update
helm install -f values.yaml kowl cloudhut/kowl
```

## Chart configuration

| Parameter | Description | Default |
| --- | --- | --- |
| `replicaCount` | Number of Kowl replicas | `1` |
| `global.imageRegistry` | Global Image Registry | (none) |
| `image.registry` | Image Registry | `quay.io` |
| `image.repository` | Docker image repo | `/cloudhut/kowl` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.tag` | Image tag | `v1.2.2` (inherited) |
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
| `service.targetPort` | Internal service port | `http` |
| `ingress.enabled` | Whether or not to deploy an ingress | `false` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts[0].host` | Ingress hostname | `chart-example.local` |
| `ingress.hosts[0].paths` | Path within the url structure | `[]` |
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
| `extraVolumes` | Add additional volumes, e. g. for tls keys | `""` |
| `extraVolumeMounts` | Add additional volumes mounts, e. g. for tls keys | `""` |
| `extraEnv` | Additional environment variables for kowl | `""` |
| `extraEnvFrom` | Additional environment variables for kowl mapped from Secret or ConfigMap | `""` |
| `extraContainers` | Add additional containers, e. g. for oauth2-proxy | `{}` |
| `kowl.config` | Kowl config content | `{}` |
| `kowl.roles` | Kowl roles config content (business) | (none) |
| `kowl.roleBindings` | Kowl rolebindings config content (business) | (none) |
| `secret.existingSecret` | Secret name of an existing secret (see notes below) | (none) |
| `secret.kafka.saslPassword` | Kafka sasl password value | (none) |
| `secret.kafka.tlsCa` | Kafka TLS ca file | (none) |
| `secret.kafka.tlsCert` | Kafka TLS cert file | (none) |
| `secret.kafka.tlsKey` | Kafka TLS key | (none) |
| `secret.kafka.tlsPassphrase` | Kafka TLS passphrase | (none) |
| `secret.kafka.schemaRegistryPassword` | Kafka schema registry password value | (none) |
| `secret.cloudhut.licenseToken` | License token for Kowl business (business) | (none) |
| `secret.keyname.cloudhut-license-token` | Secret key name for the cloudhut license token  | `cloudhut-license-token` |
| `secret.keyname.kafka-tls-passphrase` | Secret key name for the TLS passphrase  | `kafka-tls-passphrase` |
| `secret.keyname.kafka-sasl-password` | Secret key name for the SASL password  | `kafka-sasl-password` |
| `secret.keyname.kafka-schema-registry-password` | Secret key name for the schema registry password  | `kafka-schema-registry-password` |
| `login.google.clientSecret` | Google OAuth client secret (business) | (none) |
| `login.github.clientSecret` | GitHub OAuth client secret (business) | (none) |
| `login.github.personalAccessToken` | GitHub personal access token (business) | (none) |
| `login.okta.clientSecret` | Okta OAuth client secret (business) | (none) |
| `login.okta.directoryApiToken` | Okta api token for directory API (business) | (none) |
| `livenessProbe.initialDelaySeconds` | Number of seconds after the container has started before liveness probe is initiated | `0` |
| `livenessProbe.periodSeconds` | How often (in seconds) to perform the probe | `10` |
| `livenessProbe.timeoutSeconds` | Number of seconds after which the probe times out | `1` |
| `livenessProbe.successThreshold` | Minimum consecutive successes for the probe to be considered successful after having failed | `1` |
| `livenessProbe.failureThreshold` | When a probe fails, Kubernetes will try failureThreshold times before giving up | `3` |
| `readinessProbe.initialDelaySeconds` | Number of seconds after the container has started before readiness probe is initiated | `10` |
| `readinessProbe.periodSeconds` | How often (in seconds) to perform the probe | `10` |
| `readinessProbe.timeoutSeconds` | Number of seconds after which the probe times out | `1` |
| `readinessProbe.successThreshold` | Minimum consecutive successes for the probe to be considered successful after having failed | `1` |
| `readinessProbe.failureThreshold` | When a probe fails, Kubernetes will try failureThreshold times before giving up | `3` |

Further documentation can be found in the [examples](./examples).

#### Usage of the tpl Function
The tpl function allows us to pass string values from values.yaml through the templating engine. It is used for the following values:

* extraEnv
* extraEnvFrom
* extraVolumes
* extraVolumeMounts

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
