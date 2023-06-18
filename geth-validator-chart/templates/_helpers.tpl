
{{- define "labels.commons" -}}
app: goerli-validator
release: {{ .Release.Name }}
{{- end }}

{{/*
Calculate cache for Goerli node.
*/}}
{{- define "geth-public.goerli.cache" -}}
{{ div (mul (mul (atoi (toString .Values.deployment.container.geth.resources.limits.memory | trimSuffix "Gi")) 1024) 30) 100}}
{{- end -}}
