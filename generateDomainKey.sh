. setenv.sh

# do nothing if already exists
if [[ -f ${DOMAIN_KEY_PATH} ]]
then
    echo "Domain key is already generated."
else
    openssl genrsa -des3 -passout env:ROOT_CA_PASSWORD -out ${DOMAIN_KEY_PATH} 4096
    echo "Domain key generated successfully at ${DOMAIN_KEY_PATH}"
fi
openssl rsa -noout -text -in ${DOMAIN_KEY_PATH} -passin env:DOMAIN_PASSWORD
echo "Domain key verified successfully."