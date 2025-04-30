# -- namespaces --#
export CERT_MANAGER_NAMESPACE="cert-manager-baserock"
export INGRESS_NAMESPACE="ingress-nginx"
export NAMESPACE="onpremise-baserock"

#-- mongo --#
export UPCASTED_COLLECTION="testUpcastedSchemaSpec"
export MONGO_DB_PASSWORD="teste"
export MONGO_DB_NAME="microservice"
export MONGO_USERNAME="user"
export MONGO_DB_USER="root"
export MONGO_PORT="27017"
export MONGO_SERVICE="mongodb-service"
export MONGO_URL="mongodb://${MONGO_DB_USER}:${MONGO_DB_PASSWORD}@${MONGO_SERVICE}:${MONGO_PORT}/"

#-- postgres --#
export POSTGRES_DB_NAME="sapient-dev"
export POSTGRES_USERNAME="postgres"
export POSTGRES_DB_PASSWORD="teste"

#--rabbitMQ --#
export MQ_HOST_NAME="rabbitmq-service"
export MQ_USERNAME="user"
export MQ_PASSWORD="password"

#-- deployment names -- #
export CLIENT_DEPLOYMENT="client-deployment"
export UPCASTER_DEPLOYMENT="upcaster-deployment"
export FLINK_JOB_NAME="flink-aggregation-job"
export LE_SERVICE_DEPLOYMENT="learning-engine"
export MONGO_DEPLOYMENT="mongodb"
export POSTGRES_DEPLOYMENT="postgres-deployment"
export DJANGO_DEPLOYMENT="python-deployment"
export MQ_DEPLOYMENT="rabbitmq-deployment"
export MONGO_SERVICE="mongodb-service"
export DJANGO_SERVICE_DEPLOYMENT="python-service"
export POSTGRES_SERVICE_DEPLOYMENT="postgres-service"
export RABBITMQ_SERVICE_DEPLOYMENT="rabbitmq-service"

#-- ingress & Cert--#
export CLIENT_BASE_URL="/it/catalog/(.*)"
export LE_SERVICE_BASE_URL="/it/leService/(.*)"
export ISSUER_NAME="letsencrypt-production"
export CERT_SERVER="https://acme-v02.api.letsencrypt.org/directory"
export EMAIL="admin@baserock.ai"
export INGRESS_CLASS="nginx"
export HOST_PATH_TYPE="Prefix"
export INGRESS_PORT="80"

#-- port & host --#
export LE_SERVICE_PORT="80"
export LE_DJANGO_PORT="80"
export CLIENT_PORT="80"
export MONGO_EXPRESS_PORT="8081"
export RABBITMQ_PORT="5672"
export RABBITMQ_HOST="http://${RABBITMQ_SERVICE_DEPLOYMENT}.${NAMESPACE}.svc.cluster.local:${RABBITMQ_PORT}"
export POSTGRES_PORT="5432"
export POSTGRES_HOST="${POSTGRES_SERVICE_DEPLOYMENT}.${NAMESPACE}.svc.cluster.local"
export DJANGO_SERVICE_URL="http://${DJANGO_SERVICE_DEPLOYMENT}.${NAMESPACE}.svc.cluster.local:${LE_DJANGO_PORT}"
export ENCRYPTION_PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAzja06ZwzkF9XA6T3AYIv0uRyfLteMp0rzk+NSFe15Uk0wyA1\ndWNFYPv6aQQLITtTpeaLhzT022BaKOQyPGWegaKlVoqsq1Z8EY8PR8euWKxB16o7\ndPG7+zy5pRtzulgsDURwKPXnOEIAnx5yw1Dxqk1/JPlfGFwizTna3Sj67s9mIFps\nKlIXyMkj5+iPDBQQMX692MacRo9tm7q1yzpDTZeRhIK1Gdf0MxoKqJJATyn8H/9E\nQnWjnRhbOwa/+V2rRzstgUVelLkIVTi7/t/c2VLdnkXGygZRyV5jy4pmRa9ciEGi\n2Iev71/6VQk+Mps8U10A2EV2Vy+WPqoH+IkmWwIDAQABAoIBAQDJak3ST6tdvIG1\nIY/RfWNQzam1gx1Cuplq7fDFVEZqKdLLM86DVe8SB4xSvoxQbS4KwOBPs73l+HqX\nriwTKf5kCIUNvm1g/Rw52k3GgpccLUQybiec1fASOQHq7qFexXhhjRMwLt8k5/LL\neGYHuCwTd5ZUeu4TUQr9ASFxGvHeBhw3+5mDSBW4HQ148SIn2+qUYGLRd0N2J/Np\nmhjDvsqIRlZz7PK5U4Q+CrgYjtl+450tse1z/+h5U+wKE1krfoK/iF9aKo5dWHdT\naZ/602Q+EqLGnpJxudRBgGsCzyMNGRD8cuOp4nlP5GvvelVp+VzGCR5qzEmGxGLz\n+99X5drBAoGBAO9UDKqw49X9DG6fYAfpkgZj57lmaIzEDuthziOFf+/9bPVPEmFJ\nKDy9RN+G8igpg9wEKRywQXGCFfeHyTjquH+AwE0DFkBdfp6xT5D1yyDGO+dSl5pW\n6EqvLh6l50AwV+ahBNGpWNkSOthzt9nDaVF9sSK3ehkYHHyvXbueXIvJAoGBANyU\nH3yIICPAsCj/Zo3JG8J8vsXsTeJH08x+f0lRlVjmW9qi0Ar4xBMVuhO28hIb91+5\nPA8Sbi7WUQ6m8OvDUQy/u5bZOznDUY7A+TtFR7yg7HBMuxQ2iRqOrQ+HNd2l49uf\nRH7H2Yvoj1pl4EIKIX5QO5lTST5LxMFyYVItEusDAoGAG/ReUmW9Bxa6qAU3q1Tt\n+I8c1vwORDr2XyoacO28BuU8H98vj2uDJq0Y6V8S0/wdacqWnsI7sq12MWaL63kH\nOeVpENXGeJgzHQgq+gyrwFVHU/rCuIVkNq0FnxDT1RyQd+Dg9jhop1pIw1Wo6Oe5\nWopq8VorCdlWIn49XZfeyXkCgYEAwqVTQ6k781DOIt99uBCHlpBOKInmEJAhrorR\n9/kuOUzOMZkKzSPIoq7BjTQbWS+kk6v5+7Lf2CT3Ul6uqt2oX/+xoeQAB3D8P2S6\nijsQmrvG6TJMxAF76xuMS++c8QK6l8trvhTNPFD0b2kHBD+8XqKedSaxs29ZKPuu\nNb3gu9ECgYEA34hoKBHTdADZcjCD5r3GccYtzPnR5kvocFZRw0OVxdgGHBIWccTY\nHzdnEm5IUYvjWEN4hvZWNsPBaOOp20qJRl0dTHsJ7zMAlp5eeERCSExzbwG53usb\nQ2nJYfIhzz0U5MKZ+7rysOFKfJasPXsdhpcxFAvvwy8yS2PFPIGzx/8=\n-----END RSA PRIVATE KEY-----\n"
export GITHUB_APP_ID=baserock-integration-testing-prod
export GITHUB_APP_ID_INT="1221008"
export GITHUB_CLIENT_ID="GITHUB_CLIENT_ID"
export GITHUB_CLIENT_SECRET="60b0171b1b0e912dbd5b8bd55a306bb4f4e44b09"
export GITHUB_PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA/UJyelnflzPJ957vKqy5s+jQU2Af78YwkwqSLiqb5CipOP0U\nkDW+efwCaabMWgvzTHxJW0RoHa+fYsmwPU1MM3AsyjU8YR2djxKey47Ic3F9crFC\n/0XG33qq0Og3DH66A40uFzxMlpgjXgVhFIzMop2YODtopOzOHRyJl+6HPkTZoDF7\nbBKLs/Ymeof3XN95cvNO8Lo1zwY7iXx7/wogEDHkGYKMzsZM6+YMMBdr4Y82e4SU\nR4hVnxODvb7bjjbh1puqObOrd9HHhs+JUCPiJbvQtY5q1a5L9F3SHr8Ntf1iTEY4\nsf33vfJAbLPg1Whatgn6KNdhoDLJrn/eMSUtowIDAQABAoIBAQDXdU9FLe6diS66\n3ljkelvmZhvNwsqIx5iNkAG7Cv7jBYCp/g0ffsmUp8Q5s/DIbsBHArm5zqGxF7dG\naQXpsTgxzq4cPVwn1vUzQgkcblW0eQnbqFiyKd++QnLOFbC3jZyc5uAeXmtd9wKn\nu3XS8NIrSl21AT3OibP0alHYktI2MtWeZtOjLEdtoNw5WgvHiOTK+MNDpuiLHd3O\nE1dU6xPK4e63adG8WDKR0LTA68GmncqR7yRjONKwSYG1Gpumb/DR/tkbnbK+68E5\nJeOMHlWrbEmZ/M/LhV2C3SWE5KVU76Oj0WRgIY8XHOWetBGEvinipqkyZZPUzKa1\nWY1GzmtpAoGBAP9zBRkaVww4wkyAWD2JHh2lG77Y8m4Lh9b1QfcYO4ZLAZfqsM0o\n/QSmBhody6+/kXHgQ7PJD4fEnifaQh37/LGlsh5XA88Yr3pm8aSSxXyLV8zupT9A\nhkQzdo/K5HJEm3FxakaF5PUYaZkNhJ9kpTmV8inzrJq9T1x6rx5CzlEXAoGBAP3O\nOAFIO6KgCfkR7+YLny2ICN/qHMS1zfWqpyOHMi2fMyC3zzHvLWfC8kk9ED/JyBjO\nlCbbezS1GKuGkmeH0yYakk1z2BOFpmFSsJOfEeKEMzh4+iQ4jc5B7ATL5M764Vki\npbp9EJamrCzMbDwKrjUi07n2Jko5kcTKSGbanGdVAoGAFLl7L2cwqsAsG1LKVeu6\n8sLDdn9ZY84xriHlwStJIQMS1QVoZKyvomHp2tKSBOcw4KFGPN7SELzF7AvME2yv\nOqZrxgRfPb0N94tEjYqO1STk8a5m37PXcM8QDmhykka4qcJ+0cvpIG1jm9Q570iW\nEw70P60SUteLCcC2VmkrHe8CgYA7MrxRYD24osdwtsRTzeYkwpP/ViW7pAQUBufR\nG5mSlo1gVj8XkIfwqcHFX17I4hGv548auRq1on/MkijXyRBw1MXHFvwRIZ07GgRh\nijqrsNYZl+4QQLiioTGhtMT7mfyxw6kQJFeYK+wAzvV3063qauMjfsxTh7X+Rog4\npUjRuQKBgQD1fOux1gr/yo9ztLlgyEWmi9czZvCgpudcwZ54eKwDA2Etubo96kW4\nljfWpu8SXewB3Hf7GRCOeLlbm4N23XApL+YmQPWG5udoqXH8/Aheaa5HDwCFxYg2\nf90pUb2kHuoK41nqkfpEi9L34Dk/4kqoX5tWMKW1svS6f6ghL8zRZw==\n-----END RSA PRIVATE KEY-----"
export GITHUB_REDIRECT_URI="https://${DOMAIN}/it/leService/github/app/callback"

#-- misc --#

export VALUE_VERIFICATION="false"
export USE_MINIKUBE="false"

#-- backend-extras--#
export HELM_RELEASE="baserock-backend"
export IMAGE_PULL_POLICY="Always"
export INGRESS_PATH_TYPE="Prefix"
export SCHEME="https"
export EMAIL_ID="support@baserock.ai"
export USER_COUNT=1
export LICENSE_TYPE="TRIAL"


#-- resource limits --#
export CLIENT_CPUS="2"
export CLIENT_MEMORY="2Gi"
export UPCASTER_CPUS="1"
export UPCASTER_MEMORY="4Gi"
export FLINK_CPUS="2"
export FLINK_MEMORY="4Gi"
export LE_GO_CPUS="2"
export LE_GO_MEMORY="4Gi"
export MONGO_CPUS="2"
export MONGO_MEMORY="4Gi"
export POSTGRES_CPUS="2"
export POSTGRES_MEMORY="4Gi"
export DJANGO_CPUS="2"
export DJANGO_MEMORY="4Gi"
export RABBITMQ_CPUS="2"
export RABBITMQ_MEMORY="2Gi"

#-- django --#
export ANTHROPIC_MODEL_NAME="claude-3-5-sonnet-20241022"
export CHROMA_HOST="http://34.118.233.130:8000"
export CHROMA_TOKEN=""
export DEFINITION_MODE_THRESHOLD="100"
export LLM_ENABLED="True"
export MAX_TEST_CASES="10"
export POSITIVE_TEST_RATIO="0.5"

#-- todo-web-app --#
export TODO_WEB_SERVICE_URL="https://${DOMAIN}/todo"
export CONTEXT_PATH="/todo-ui"
export SERVER_PORT="8080"
export TODO_WEB_APP_CPUS="1"
export TODO_WEB_APP_MEMORY="2Gi"
