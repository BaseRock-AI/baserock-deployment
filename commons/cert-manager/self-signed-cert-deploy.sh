

envsubst < san.cnf | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -extensions req_ext -config -

kubectl create secret tls "${CERTIFICATE_NAME}" \
  --key tls.key --cert tls.crt \
  -n "${NAMESPACE}"

#for mac: ( to add to keychain)
# sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain tls.crt
#windows powershell :
#Import-Certificate -FilePath "C:\path\to\tls.crt" -CertStoreLocation "Cert:\LocalMachine\Root"
#linux:
#sudo cp tls.crt /usr/local/share/ca-certificates/baserock.crt
#sudo update-ca-certificates
envsubst < commons/cert-manager/self-signed-cert.yaml | kubectl apply -f -
