{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kowl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kowl.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kowl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kowl.labels" -}}
helm.sh/chart: {{ include "kowl.chart" . }}
{{ include "kowl.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kowl.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kowl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kowl.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kowl.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Secret Name (either existing or just created secret name)
*/}}
{{- define "kowl.secretName" -}}
{{- default (include "kowl.fullname" .) .Values.secret.existingSecret }}
{{- end }}

{{/*
Server Listen Port for Kowl
*/}}
{{- define "kowl.serverListenPort" -}}
{{- if .Values.kowl.config.server -}}
{{- .Values.kowl.config.server.listenPort | default 8080 }}
{{- else -}}
8080
{{- end }}
{{- end }}

{{- define "kowl.imagesRegistryName" -}}
{{- $registryName := .Values.image.registry -}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s" .Values.global.imageRegistry -}}
    {{- else -}}
        {{- printf "%s" $registryName -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s" $registryName -}}
{{- end -}}
{{- end -}}
