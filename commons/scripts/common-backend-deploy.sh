chmod +x backend/commons/helm.sh
chmod +x commons/db/database.sh
chmod +x commons/scripts/deploy.sh
chmod +x integration-testing/commons/delete.sh
chmod +x integration-testing/commons/redeploy-commons.sh
chmod +x integration-testing/commons/redeploy-services.sh

./integration-testing/commons/delete.sh
./integration-testing/commons/redeploy-commons.sh
./integration-testing/commons/redeploy-services.sh
./backend/commons/helm.sh
./commons/db/database.sh
./commons/scripts/deploy.sh
