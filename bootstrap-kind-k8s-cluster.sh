#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

source "${BASH_SOURCE%/*}/scripts/bash-import.sh"

check_prereq kind
check_prereq kubectl
check_prereq kubeseal
check_prereq kustomize

# creating kind cluster.
kind create cluster --config=kind-clstr-config.yaml

# applying bitnami sealed-secrets.
kustomize build kustomize/sealed-secrets/ | kubectl apply -f -

# applying nginx ingress controller.
kustomize build kustomize/nginx-ingress/ | kubectl apply -f -
