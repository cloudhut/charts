{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-owl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka-owl.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka-owl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kafka-owl.labels" -}}
app.kubernetes.io/name: {{ include "kafka-owl.name" . }}
helm.sh/chart: {{ include "kafka-owl.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Since the user can specify either the name of a kubernetes secret,
or specify values for their 'ca', 'cert', and 'key' directly (for which we will generate a kubernetes secret then),
we can't know the name of the secret in advance.
So this method finds the correct name 
*/}}
{{- define "kafka-owl.tlsSecretName" -}}
{{- default "kafka-owl-tls-certificates" .Values.kafka.tls.existingSecretName -}}
{{- end -}}

{{/*
Same thing as 'kafka-owl.tlsSecretName', but for sasl instead.
*/}}
{{- define "kafka-owl.saslSecretName" -}}
{{- default "kafka-owl-sasl-credentials" .Values.kafka.sasl.existingSecretName -}}
{{- end -}}