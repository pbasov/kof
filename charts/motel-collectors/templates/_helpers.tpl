{{- /* Basic auth extensions */ -}}
{{- define "basic_auth_extensions" -}}
{{- range tuple "metrics" "logs" }}
{{- $secret := (lookup "v1" "Secret" $.Release.Namespace (index $.Values "motel" . "credentials_secret_name")) }}
{{- if $secret }}
basicauth/{{ . }}:
  client_auth:
    username: {{ index $secret.data (index $.Values "motel" . "username_key") | b64dec | quote }}
    password: {{ index $secret.data (index $.Values "motel" . "password_key") | b64dec | quote }}
{{- end }}
{{- end }}
{{- end }}

