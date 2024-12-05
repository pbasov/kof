## add helm repo
helm repo add
## deploy mothership chart
helm upgrade -i mothership pbasov/motel-motheship -n hmc-system -f demo-mothership-values.yaml

## deploy demo regional managedcluster
kubectl apply -f ./cluster/aws-motel-regional.yaml

## deploy demo child cluster
kubectl apply -f ./cluster/aws-motel-child.yaml

## pull kubeconfig
kubectl get secret -o jsonpath={.data.value} -n motel aws-motel-regional-kubeconfig | base64 -d > /tmp/regional-kc.yaml

## pull auth creds
KUBECONFIG=/tmp/regional-kc.yaml kubectl get secret -o jsonpath={'data.admin-password'} | base64 -d > /tmp/regional-grafana.yaml

## print links and creds
echo $INGRESS
echo admin:$(cat /tmp/regional-grafana.yaml)

## deploy a second set
kubectl apply -f  ./cluster/aws-motel-child.yaml

# pull mothership creds

# print mothership link and creds (port-forward?)