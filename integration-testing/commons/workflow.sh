#!/bin/bash

chmod +x commons/redeploy-all.sh

echo "Redeploying all with redeploy-all.sh..."
./commons/redeploy-all.sh || exit
if [ $? -ne 0 ]; then
  echo "Redeployment failed."
  exit 1
fi

