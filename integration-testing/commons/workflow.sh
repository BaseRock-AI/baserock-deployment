#!/bin/bash

chmod +x integration-testing/commons/redeploy-all.sh

echo "Redeploying all with redeploy-all.sh..."
./integration-testing/commons/redeploy-all.sh || exit
if [ $? -ne 0 ]; then
  echo "Redeployment failed."
  exit 1
fi

