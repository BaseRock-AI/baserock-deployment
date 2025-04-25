{{/*
Expand the name of the chart.
*/}}
{{- define "baserock-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "baserock-backend.fullname" -}}
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
{{- define "baserock-backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "baserock-backend.labels" -}}
helm.sh/chart: {{ include "baserock-backend.chart" . }}
{{ include "baserock-backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "baserock-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "baserock-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{/*
Get the PostgreSQL hostname
*/}}
{{- define "baserock-backend.postgresql.host" -}}
{{- printf "%s-postgresql" .Release.Name -}}
{{- end -}}

{{/*
Get the Redis hostname
*/}}
{{- define "baserock-backend.redis.host" -}}
{{- printf "%s-redis-master" .Release.Name -}}
{{- end -}}

{{- define "baserock-backend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ .Release.Name }}-service-account
{{- else -}}
default
{{- end -}}
{{- end -}}