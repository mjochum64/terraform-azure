#!/bin/bash

echo "Starting Pre-Container-Start-Jobs ..."

# if docker search ${REGISTRY_NAME}/ --limit 1 &> /dev/null;
# then
#   echo "Already logged in to ${REGISTRY_NAME} acr!"
#   # do nothing because already logged in
#   exit 0;
# else
#   echo "Trying to log in to ${REGISTRY_NAME} acr..."
#   if az account show --subscription ${SUBSCRIPTION_ID} &> /dev/null;
#   then
#     az acr login --name stollfuss --subscription ${SUBSCRIPTION_ID}
#   else
#     echo "Logging in to azure first then to stollfuss acr..."
#     az login && az acr login --name ${SUBSCRIPTION_NAME} --subscription ${SUBSCRIPTION_ID}
#   fi
# fi