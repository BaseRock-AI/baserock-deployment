#!/bin/bash
source ./commons/messaging.sh
HEALTH_API_URL="${SCHEME}://${DOMAIN}/actuator/health"
RETRY_INTERVAL=7

print_status "health api : ${HEALTH_API_URL}"
while true; do
    RESPONSE_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "$HEALTH_API_URL")

    if [ "$RESPONSE_CODE" -eq 200 ]; then
        echo "Health check passed! API is up."
        break
    else
        echo "Waiting for API to be up... (Last response: $RESPONSE_CODE)"
        sleep $RETRY_INTERVAL
    fi
done
