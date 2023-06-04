#!/usr/bin/env bash

. _terraform_cmds

set -o errexit
set -o nounset
PARAM_LIST=( ACCOUNT_ID ENVIRONMENT REGION COMPONENT COMMAND )

function usage() {
    echo "$0 ${PARAM_LIST[*]} [EXTRA_TERRAFORM_PARAMS]"
    echo ""
    echo account_id: "Account ID to provision on"
    echo region: "Deployment region"
    echo commands: "$COMMANDS"
    exit 0
}

if [[ $# -lt 5 ]]
then
    usage
fi

for param in "${PARAM_LIST[@]}"; do
    printf -v "$param" "$1" && shift
done

$COMMAND "$@"