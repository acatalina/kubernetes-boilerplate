# Kubernetes boilerplate

This repo contains files to deploy a kubernetes cluster and apps included.

## Folders information

### Nginx-ingress folder

Contains yaml files to deploy a succesful nginx, kube-lego and a default http backend. This will allow the cluster to provide dynamic SSL certificates to the apps running in the cluster.

### Deployment folder

Contains yaml files to deploy all the rydr stack into the kubernetes cluster. There are three types of files: 

1. appname.yaml: creates the actual deployment of the app.
2. appname-service.yaml: exposes the app as a service visible to all the nodes.
3. appname-ingress.yaml: creates an ingress rule to expose the app through a defined host.

## Deployment

1. Make sure you are not connected already into a kubernetes cluster!!
2. ```sh ./deploy.sh```
3. Pray
4. Enjoy!