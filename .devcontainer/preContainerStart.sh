#!/bin/bash

# Setzen von git-config-Werten, von denen bekannt ist, dass sie Git-Fehler beheben
# Line endings (#4069)
git config core.eol lf
git config core.autocrlf false
# zeroPaddedFilemode fsck errors (#4963)
git config fsck.zeroPaddedFilemode ignore
git config fetch.fsck.zeroPaddedFilemode ignore
git config receive.fsck.zeroPaddedFilemode ignore
# autostash on rebase (#7172)
resetAutoStash=$(git config --bool rebase.autoStash 2>/dev/null)
git config rebase.autoStash true

RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
DIM=$(printf '\033[2m')
UNDER=$(printf '\033[4m')
RESET=$(printf '\033[m')

printf '\033[38;5;196m'
printf '                _       __              __     \n' $RESET
printf '\033[38;5;202m'
printf '   ____ ___    (_)     / / _____ ____  / /____ \n' $RESET
printf '\033[38;5;226m'
printf '  / __ `__ \  / /_____/ __/ __ \/ __ \/ / ___/ \n' $RESET
printf '\033[38;5;082m'
printf ' / / / / / / / /_____/ /_/ /_/ / /_/ / (__  )  \n' $RESET
printf '\033[38;5;021m'
printf '/_/ /_/ /_/_/ /      \__/\____/\____/_/____/   \n' $RESET
printf '\033[38;5;093m'
printf '         /___/                                 \n' $RESET
printf '\n'
printf "${BLUE}%s${RESET}\n" "Starting Pre-Container-Start-Jobs"
printf '\n' $RESET

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
