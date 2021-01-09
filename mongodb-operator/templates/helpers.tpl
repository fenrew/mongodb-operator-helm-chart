{{/*
Expand the name of the chart.
*/}}
{{- define "mongodb.operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongodb.operator.fullname" -}}
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
LABELS
*/}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongodb.operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* 
Labels specific for the mongodb operator
*/}}

{{- define "mongodb.operator.labels" -}}
helm.sh/chart: {{ include "mongodb.operator.chart" . }}
{{- if or .Chart.AppVersion .Values.mongodb.image.tag }}
app.kubernetes.io/version: {{ .Values.mongodb.image.tag | default .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "mongodb.operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongodb.operator.name" . }}
{{- end -}}