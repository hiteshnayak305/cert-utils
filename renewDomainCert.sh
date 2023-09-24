. setenv.sh

# Ask confirmation
echo "Domain is valid till : "
openssl x509 -enddate -noout -in ${DOMAIN_CRT_PATH}
read -p "This will invalidate existing Domain certificate. Are you sure wan't to continue? y/n [n] " yn

case $yn in
    [Yy]* ) 
        mv -b ${DOMAIN_CRT_PATH} ${DOMAIN_CRT_OLD_PATH}
        echo "Moving existing crt to ${DOMAIN_CRT_OLD_PATH}"
        openssl x509 -x509toreq -in ${DOMAIN_CRT_OLD_PATH} -signkey ${DOMAIN_KEY_PATH} -passin env:DOMAIN_PASSWORD -out ${DOMAIN_CSR_PATH} -extfile ${DOMAIN_OPENSSL_CONF_PATH} -extensions v3_req
        echo "Domain renewal csr generated successfully at ${DOMAIN_CSR_PATH}"
        openssl x509 -req -in ${DOMAIN_CSR_PATH} -CA ${ROOT_CA_CRT_PATH} -CAkey ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD -out ${DOMAIN_CRT_PATH} -days ${DOMAIN_EXPIRY_DAYS} -extfile ${DOMAIN_OPENSSL_CONF_PATH} -extensions v3_req
        echo "Domain crt generated successfully at ${DOMAIN_CRT_PATH}"
        #rm ${DOMAIN_CSR_PATH}
        echo "Removing csr file ${DOMAIN_CSR_PATH}";;
    [Nn]* ) exit;;
        * ) exit;;
esac
# print crt details
openssl x509 -noout -text -in ${DOMAIN_CRT_PATH}
# verify integrity
openssl x509 -noout -modulus -in ${DOMAIN_CRT_PATH} | openssl md5
openssl rsa -noout -modulus -in ${DOMAIN_KEY_PATH} -passin env:DOMAIN_PASSWORD | openssl md5
echo "Domain crt and key verified successfully."
