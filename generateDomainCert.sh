. ./setenv.sh

# do nothing if already exists
if [[ -f ${DOMAIN_CRT_PATH} ]]
then
    echo "Domain crt is already generated."
else
    openssl req -new -key ${DOMAIN_KEY_PATH} -out ${DOMAIN_CSR_PATH} -config ${DOMAIN_OPENSSL_CONF_PATH} #-passin env:DOMAIN_PASSWORD
    openssl x509 -req -in ${DOMAIN_CSR_PATH} -CA ${ROOT_CA_CRT_PATH} -CAkey ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD -out ${DOMAIN_CRT_PATH} -days ${DOMAIN_EXPIRY_DAYS} -extfile ${DOMAIN_OPENSSL_CONF_PATH} -extensions v3_req
    echo "Domain crt generated successfully at ${DOMAIN_CRT_PATH}"
    rm ${DOMAIN_CSR_PATH}
    echo "Removing csr file ${DOMAIN_CSR_PATH}"
fi
# print crt details
openssl x509 -noout -text -in ${DOMAIN_CRT_PATH}
# verify integrity
openssl x509 -noout -modulus -in ${DOMAIN_CRT_PATH} | openssl md5
openssl rsa -noout -modulus -in ${DOMAIN_KEY_PATH} -passin env:DOMAIN_PASSWORD | openssl md5
echo "Domain crt and key verified successfully."
