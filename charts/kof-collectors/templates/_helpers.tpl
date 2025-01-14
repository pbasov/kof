{{- /* Basic auth extensions */ -}}
{{- define "basic_auth_extensions" -}}
{{- range tuple "metrics" "logs" }}
{{- $secret := (lookup "v1" "Secret" $.Release.Namespace (index $.Values "kof" . "credentials_secret_name")) }}
{{- if not $.Values.global.lint }}
basicauth/{{ . }}:
  client_auth:
    username: {{ index $secret.data (index $.Values "kof" . "username_key") | b64dec | quote }}
    password: {{ index $secret.data (index $.Values "kof" . "password_key") | b64dec | quote }}
{{- end }}
{{- end }}
{{- end }}

