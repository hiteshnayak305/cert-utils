. ./setenv.sh

# do nothing if already exists
if [[ -f ${DOMAIN_DEC_KEY_PATH} ]]
then
    echo "Domain decrypted key is already generated."
else
    openssl rsa -in ${DOMAIN_KEY_PATH} -out ${DOMAIN_DEC_KEY_PATH} #-passin env:DOMAIN_PASSWORD
    echo "Domain decrypted key generated successfully at ${DOMAIN_DEC_KEY_PATH}"
fi
