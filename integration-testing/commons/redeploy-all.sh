#!/bin/bash

chmod +x integration-testing/commons/delete.sh
chmod +x integration-testing/commons/redeploy-commons.sh
chmod +x integration-testing/commons/redeploy-services.sh

./integration-testing/commons/delete.sh
./integration-testing/commons/redeploy-commons.sh
./integration-testing/commons/redeploy-services.sh





