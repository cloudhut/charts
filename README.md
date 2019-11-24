# Kafka Owl Helm Chart

Helm chart for deployment of Kafka Owl

## Intalling the chart

```
helm repo add kafka-owl https://raw.githubusercontent.com/kafka-owl/helm-chart/master
helm repo update
helm install --name=kafka-owl kafka-owl/kafka-owl
```

## Chart configuration

| Parameter | Description | Default |
| --- | --- | --- |
| `replicaCount` | Number of replicas in the deployment | `1` |
| `nameOverride` | Override the name used in the labels | `kafka-owl` |
| `fullnameOverride` | Override the deployment name | `kafka-owl` |
| `imagePullSecrets` | Secrets for pulling the docker image | `[]` |
| `image.repository` | Docker image repository | `quay.io/kafka-owl/kafka-owl` |
| `image.tag` | Docker image tag | `latest` |
| `image.pullPolicy` | Under which circumstance the Kubelet shall download the image | `IfNotPresent` |
| `server.http.listenPort` | HTTP Port to listen on for the Kafka Owl Backend | `8080` |
| `logging.level` | Log messages only with the given severity or above. Valid levels: [debug, info, warn, error] | `info` |
| `kafka.brokers` | Kafka Broker addresses (comma separated) | (no default) |
| `kafka.client-id` | ClientID to identify the consumer | `kafka-owl` |
| `kafka.sasl.enabled` | Whether or not to use SASL authentication | `false` |
| `kafka.sasl.useHandshake` | Whether or not to send a SASL handshake first | `true` |
| `kafka.sasl.existingSecretName` | Use existing secret for SASL Credentials (keys must be "username" and "password"). Mutually exclusive with sasl.username & sasl.password | (no default) |
| `kafka.sasl.username` | SASL username | (no default) |
| `kafka.sasl.password` | SASL password | (no default) |
| `kafka.tls.enabled` | Whether or not to use TLS | `false` |
| `kafka.tls.existingSecretName` | Use existing secret for TLS certs (key names must comply with the expected keys). Mutually exclusive with `kafka.tls.ca`, `kafka.tls.cert` & `kafka.tls.key` | (no default) |
| `kafka.tls.ca` | TLS ca file | (no default) |
| `kafka.tls.cert` | TLS cert file | (no default) |
| `kafka.tls.key` | TLS key file | (no default) |
| `kafka.tls.passphrase` | Passphrase to decrypt the TLS key (leave empty for unencrypted key files) | `""` |
| `kafka.tls.insecure-skip-verify` | If InsecureSkipVerify is true, TLS accepts any certificate presented by the server and any host name in that certificate. | `false` |
| `service.type` | Service Type | `ClusterIP` |
| `service.port` | Service Port | `80` |
| `ingress.enabled` | Whether or not to create an Ingress resource | `false` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts | (sample Ingress host) |
| `ingress.tls` | TLS certs for ingress hosts | `[]` |
| `resources` | Resource constraints used for the deployment | `{}` |
| `nodeSelector` | Node selection constraint | `{}` |
| `tolerations` | Toleratians applied to the pods | `[]` |
| `serviceMonitor.create` | Whether or not to create a service monitor for prometheus operator | `false` |
| `serviceMonitor.interval` | Scrape interval for prometheus operator | `10s` |
| `serviceMonitor.scrapeTimeout` | Scrape timeout for prometheus operator | `10s` |
| `serviceMonitor.releaseLabel` | Release label being used for prometheus operator selector | `prometheus-operator` |
| `serviceMonitor.additionalLabels` | Additional labels to add to the ServiceMonitor | (none) |
| `affinity` | Affinities and anti affinities | `{}` |
| `podAnnotations` | Additional pod annotations | `{}` |
| `priorityClassName` | Priority Class to be used by the pod | `""` |
| `podSecurityContext.runAsUser` | UserID to use for the pod | `99` |
| `podSecurityContext.fsGroup` | User group to use for the pod | `99` |
| `containerSecurityContext` | Security Context for the kafka minion container | `{}` |

## SASL/SSL Setup

When configuring SASL or TLS you can either provide the secretname of an existing secret **or** pass the contents as values. When you choose to create the secrets on your own, please make sure you comply with the key names used in this chart:

#### SASL

Key names are `username` and `password`.

```yml
type: Opaque
data:
  username:
  password:
```

#### TLS

Key names are `ca`, `cert`, `key` and `passphrase`.

```yml
type: Opaque
data:
  ca:
  cert:
  key:
  passphrase:
```
