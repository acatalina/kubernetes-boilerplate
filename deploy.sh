#!/bin/bash

# Store base directory for starting point of script executions
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GCP_PROJECT=PROJECT
GCP_ZONE=ZONE
GCP_MACHINE_TYPE=n1-standard-1
NUM_NODES=1
GCP_NAME=APPNAME

build_gcp_cluster() {
  printf "\nAbout to create '$GCP_NAME' Cluster in the '$GCP_PROJECT' project located in '$GCP_ZONE' with $NUM_NODES x '$GCP_MACHINE_TYPE' node(s)\n"
  read -rsp $'Press any key to continue...or Ctrl+C to exit\n' -n1 key

  gcloud container clusters create "$GCP_NAME" \
  --zone "$GCP_ZONE" \
  --machine-type "$GCP_MACHINE_TYPE" \
  --num-nodes "$NUM_NODES" \
  --network "default" \
  --username "admin"

  gcloud config set container/cluster $GCP_NAME
  gcloud container clusters get-credentials $GCP_NAME
}

create_nginx_controller() {
  printf "\nCreating dynamic SSL...\n"
  kubectl apply -f $BASE_DIR/nginx-ingress/
}

deploy_apps() {
  printf "\nDeploying apps...\n"
  kubectl apply -f $BASE_DIR/deployment/
}

_main() {

  printf "\nStarting deployment script...."

  # Build gcloud cluster
  build_gcp_cluster

  # Create nginx, kubelego and default http server for dynamic SSL
  create_nginx_controller

  # Deploy all the apps, includes services and ingress rules
  deploy_apps

  printf "\nCompleted!!\n\n"
}

_main
